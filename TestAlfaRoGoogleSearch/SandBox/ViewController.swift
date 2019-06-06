//
//  ViewController.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Roman Melnik  on 05.04.2019.
//  Copyright © 2018 NGSE. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

enum LayoutType {
    case grid
}

class ViewController: UIViewController{
    var datas: [GoogleData] = [GoogleData]()
    var layoutType: LayoutType = .grid
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoogleSearch()
    }
//    override func didReceiveMemoryWarning() {
//        //super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    @IBAction func search(_ sender: UIButton) {       
    }
}

//MARK: - Table View
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
        cell.backgroundColor = .green
        
        // Don't sleep screen
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Create asynchrone treads
        DispatchQueue.global().async {
            let data = self.datas[indexPath.row]
            DispatchQueue.main.async {
                cell.dataGoogleTextViev!.text = self.layoutType == .grid ? data.dataSearch : data.searchURL
            }
        }
        return cell
    }
}

// MARK: - SearchBar
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getGoogleSearch(searchText: searchBar.text)
    }
}

//MARK: - Networking
extension ViewController {
    func getGoogleSearch(searchText: String? = nil){
        MBProgressHUD.showAdded(to: view, animated: true)
        fetchGoogleSearch(searchText: searchText) { [weak self](datas) in
            guard let strongSelf = self else {return}
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            self?.tableView.reloadData()
        }
    }
    func fetchGoogleSearch(searchText: String? = nil, completion: (([Data]?) -> Void)? = nil){
        let url = URL(string: "https://www.googleapis.com/customsearch/v1?")
        var parameters = [
            "key": "AIzaSyB3YD_DYoLruCYPTR170RJ-Hd6mL1xa7gc",
            "q": "cat",
            "num": "10",
            "cx": "018374168168575018408:yxsv8t-uj2m"
            
        ]
        if let searchText = searchText {
            parameters ["q"] = searchText
        }
        print("seichas povaliat kalovaie massa")
        Alamofire.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseString(completionHandler: { response in
                print("response = \(response)")
            })
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    self.datas.removeAll()
                    for item in json["items"].arrayValue {
                        let gData = GoogleData()
                        gData.dataSearch = item["title"].stringValue
                        gData.searchURL = item["link"].stringValue
                        //print("d111111111111111111111 = \(gData.dataSearch)")
                        //print("111111111111111111111\(gData.searchURL)")
                        self.datas.append(gData)
                    }
                    //print("datas = \(self.datas)")
                    //self.tableView.reloadData()
                    completion?(nil)
                case .failure(let error):
                    print ("error while fetching data: \(error.localizedDescription)")
                    completion?(nil)
                }
        }
    }
}
