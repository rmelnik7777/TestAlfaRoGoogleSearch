//
//  TableViewCell.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/10/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var tableViewCell: UILabel!
    
    func update(listItem: SearchListPresentationItem) {
        tableViewCell.text = listItem.searchText
        print("11111111 - ", listItem.searchText)
    }

}
