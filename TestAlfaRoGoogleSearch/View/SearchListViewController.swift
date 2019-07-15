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
    var evensHendler: SearchListEventsHandler? = SearchListPresenter()
    var data: [SearchListPresentationItem] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func didTapStopSearchButton(_ sender: UIButton) {
        evensHendler?.stopSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.tintColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        searchBar.barTintColor = UIColor(red: 96.0/255.0, green: 108.0/255.0, blue: 193.0/255.0, alpha: 2.0)
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
        cell.update(listItem: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: data[indexPath.row].url)! as URL, options: [:], completionHandler: nil )

    }
}



// MARK: - SearchBar
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            progresBar()
            return
        }
        progresBar()
        evensHendler?.search(text: searchText, keyStop: 0)
    }
    public func  progresBar() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Заливаю тебе вирус..."
        hud.hide(animated: true)
    }
}

extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
        progresBar()
        data.append(contentsOf: items)
        tableView.reloadData()
        debugPrint(items)
    }
}
