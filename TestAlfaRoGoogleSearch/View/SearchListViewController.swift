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

class SearchListViewController: UIViewController {
   
//MARK: - Variable
    var evensHendler: SearchListEventsHandler? = SearchListPresenterMock()
    private var data: [SearchListPresentationItem] = []
    private var filterSearchData: [SearchListPresentationItem] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func didTapStopSearchButton(_ sender: UIButton) {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let item = filterSearchData[indexPath.row]
        cell.update(listItem: item)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filterSearchData[indexPath.row].url)
        UIApplication.shared.open(URL(string: filterSearchData[indexPath.row].url)! as URL, options: [:], completionHandler: nil )

    }
}

// MARK: - SearchBar
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            filterSearchData = []
            reloadProgres()
            return
        }
        filterSearchData = data.filter({ SearchListPresentationItem -> Bool in
            return SearchListPresentationItem.title.contains(searchText)
        })
        reloadProgres()
    }
    
    func  reloadProgres () {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Заливаю тебе вирус..."
        hud.hide(animated: true)
        tableView.reloadData()
    }
}

extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
        data.append(contentsOf: items)
        tableView.reloadData()
        debugPrint(items)
    }
}
