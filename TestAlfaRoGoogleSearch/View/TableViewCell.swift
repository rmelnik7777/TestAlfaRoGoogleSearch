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
    @IBOutlet weak var imageViewCell: UIImageView!
    
    func update(listItem: SearchListPresentationItem) {
        lableViewCell.numberOfLines = 0 //Количество строк, которые будут отображаться в ячейке
        lableViewCell.text = String(listItem.title.prefix(30)) //Максимальное количество символов, отображаемых в строке
        imageViewCell.image = UIImage(named: listItem.image) //Вывод картинки соответствующего потока
    }
}
