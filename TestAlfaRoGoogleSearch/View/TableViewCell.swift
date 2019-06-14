//
//  TableViewCell.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/10/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lableViewCell: UILabel!
    
    func update(listItem: SearchListPresentationItem) {
        lableViewCell.text = listItem.title
    }
}
