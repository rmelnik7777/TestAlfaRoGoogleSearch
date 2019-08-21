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
    let hud = MBProgressHUD()
    
    var realm = try? Realm() // Доступ к хранилищу
    var dataStorage = [DataStorage]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func didTapStopSearchButton(_ sender: UIButton) {
        eventsHendler?.stopSearch()
        hud.hide(animated: true)
    }
    
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
        return dataStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellReusableId, for: indexPath) as! TableViewCell
        cell.update(listItem: dataStorage[indexPath.row])
        hud.hide(animated: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: dataStorage[indexPath.row].url)! as URL, options: [:], completionHandler: nil )
    }
}

// MARK: - SearchBar
extension SearchListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.progresBar()
        dataStorage.removeAll()
        if let result = realm?.objects(DataStorage.self) {
            try? realm?.write {
                realm?.delete(result)
            }
        }

        guard !searchText.isEmpty else {
            hud.hide(animated: true)
            tableView.reloadData()
            return
        }
        eventsHendler?.search(text: searchText)
    }
    
    public func  progresBar() {
        hud.label.text = "Идет загрузка данных"
        view.addSubview(hud)
        hud.isUserInteractionEnabled = false
        hud.show(animated: true)
    }
}

extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
        items.forEach { (item) in
            let newItem = DataStorage(item: item)
            dataStorage.append(newItem)
        }
        try? realm!.write {
            realm?.add(dataStorage, update: true)
            tableView.reloadData()
        }
        //tableView.reloadData()
    }
}
