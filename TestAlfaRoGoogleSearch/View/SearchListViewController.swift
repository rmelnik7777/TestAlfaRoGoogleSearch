//
//  SearchListViewController.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 1/6/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit
import MBProgressHUD
import Foundation
import RealmSwift

class SearchListViewController: UIViewController {
   
    enum Constants {
        static let tableViewCellReusableId  = "TableViewCell"
    }
    
    
//MARK: - Variable
    var eventsHendler: SearchListEventsHandler? = SearchListPresenter()
//    var data: [SearchListPresentationItem] = []
    
    var realm = try? Realm() // Доступ к хранилищу
    var dataStorage = [DataStorage]() //Контейнер со свойствами объекта DataStorage
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func didTapStopSearchButton(_ sender: UIButton) { eventsHendler?.stopSearch() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.tintColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        searchBar.barTintColor = UIColor(red: 96.0/255.0, green: 108.0/255.0, blue: 193.0/255.0, alpha: 2.0)
        eventsHendler?.view = self
        
        if let result = realm?.objects(DataStorage.self) {
            dataStorage = Array(result)
        }
    }
}


//MARK: - Table View
extension SearchListViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data.count
        return dataStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellReusableId, for: indexPath) as! TableViewCell

//        cell.update(listItem: data[indexPath.row])
        cell.update(listItem: dataStorage[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataStorage[indexPath.row].url)
        UIApplication.shared.open(URL(string: dataStorage[indexPath.row].url)! as URL, options: [:], completionHandler: nil )
    }
}



// MARK: - SearchBar
extension SearchListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        progresBar()
        //data.removeAll()
        dataStorage.removeAll()
        if let result = realm?.objects(DataStorage.self) {
            try? realm?.write {
                realm?.delete(result)
            }
            //dataStorage = Array(result)
        }

        guard !searchText.isEmpty else {
            progresBar()
            tableView.reloadData()
            return
        }
//        progresBar()
        eventsHendler?.search(text: searchText)
    }
    public func  progresBar() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Заливаю тебе вирус..."
        hud.hide(animated: true)
    }
}

extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
//        data.append(contentsOf: items)
//        data.forEach { (items) in
        items.forEach { (item) in
            let newItem = DataStorage(item: item)
            print("newItem🐥🐥🐥🐥🐥 \(newItem)")
            dataStorage.append(newItem)
        }
        
        try? realm!.write {
            realm?.add(dataStorage, update: true)
            tableView.reloadData()
        }
        tableView.reloadData()
        debugPrint(items)
    }
}
