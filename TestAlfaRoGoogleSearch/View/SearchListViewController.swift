//
//  SearchListViewController.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/3/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController    {
   
    //MARK: - Variable
    var evensHendler: SearchListEventsHandler? = SearchListPresenterMock()
    var datas: [SearchListPresentationItem] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        evensHendler?.view = self
        evensHendler?.ready()
        print ("countString -", datas.count)
        //self.tableView.dataSource = self;
        //self.tableView.delegate = self;
        //searchController = UISearchController(searchResultsController: nil)
    }
}


extension SearchListViewController: UITableViewDataSource, UITableViewDelegate  {

// number of rows in table view
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("gektor")
    print("1111", datas)
    return datas.count
}

// create a cell for each table view row
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
    print("kon")
    let item = datas[indexPath.row]
    
    cell.update(listItem: item)
    print(item)
    return cell
    }
}

extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
        datas.append(contentsOf: items)
        tableView.reloadData()
        debugPrint(items)
    }
}

