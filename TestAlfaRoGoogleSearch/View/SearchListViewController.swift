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
   
    enum Constants {
        static let tableViewCellReusableId  = "TableViewCell"
    }
    
//MARK: - Variable
    //var evensHendler: SearchListEventsHandler? = SearchListPresenterMock()
    var evensHendler: SearchListEventsHandler? = SearchListPresenter()
    var data: [SearchListPresentationItem] = []
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func didTapStopSearchButton(_ sender: UIButton) {
        evensHendler?.stopSearch()
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellReusableId, for: indexPath) as! TableViewCell
        let item = data[indexPath.row]
        cell.update(listItem: item)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row].url)
        UIApplication.shared.open(URL(string: data[indexPath.row].url)! as URL, options: [:], completionHandler: nil )

    }
}

// MARK: - SearchBar
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            data = []
            reloadProgres()
            return
        }
        evensHendler?.search(text: searchText)
    }
    func  reloadProgres() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Заливаю тебе вирус..."
        hud.hide(animated: true)
    }
}

extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
        data.append(contentsOf: items)
        tableView.reloadData()
        debugPrint(items)
    }
}
