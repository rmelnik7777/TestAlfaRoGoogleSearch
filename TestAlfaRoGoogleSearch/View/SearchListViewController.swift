//
//  SearchListViewController.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/3/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController {
    var evensHendler: SearchListEventsHandler? = SearchListPresenterMock()

    @IBOutlet weak var DataCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        evensHendler?.view = self
       evensHendler?.ready()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SearchListViewController: SearchListView {
    func update(items: [SearchListPresentationItem]) {
    debugPrint(items)
    }
    
    
}
