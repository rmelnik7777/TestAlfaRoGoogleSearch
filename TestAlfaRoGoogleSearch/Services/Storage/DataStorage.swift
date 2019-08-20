//
//  DataStorage.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 8/15/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import RealmSwift

class DataStorage: Object {

    override static func primaryKey() -> String? {
        return "title"
    }

    @objc dynamic var title: String = ""
    @objc dynamic var  url: String = ""
    @objc dynamic var  image: String = ""
    

    convenience init (item: SearchListPresentationItem) {
        self.init()
        self.title = item.title
        self.url = item.url
        self.image = item.image
    }
    

}
