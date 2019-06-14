//
//  SearchListViewController.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/3/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit
import MBProgressHUD

class SearchListViewController: UIViewController {
   
    //MARK: - Variable
    var evensHendler: SearchListEventsHandler? = SearchListPresenterMock()
    var datas: [SearchListPresentationItem] = []
    private var filterSearchDatas: [SearchListPresentationItem] = []
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func stopSearchButton(_ sender: UIButton) {
        
        print("Нажата кнопка")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        evensHendler?.view = self
        evensHendler?.ready()
    }
}
//MARK: - Table View
extension SearchListViewController: UITableViewDataSource, UITableViewDelegate  {

// number of rows in table view
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //return filterSearchDatas.count
    return filterSearchDatas.count
}

// create a cell for each table view row
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let item = filterSearchDatas[indexPath.row]
        cell.update(listItem: item)
    return cell
    }
}

// MARK: - SearchBar
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Заливаю тебе вирус..."
        guard !searchText.isEmpty else {
            filterSearchDatas = []
            hud.hide(animated: true)
            tableView.reloadData()
            return
        }
        filterSearchDatas = datas.filter({ SearchListPresentationItem -> Bool in
            return SearchListPresentationItem.title.contains(searchText)
        })
        hud.hide(animated: true)
        tableView.reloadData()
    }
}


extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
        datas.append(contentsOf: items)
        tableView.reloadData()
        debugPrint(items)
    }
}
