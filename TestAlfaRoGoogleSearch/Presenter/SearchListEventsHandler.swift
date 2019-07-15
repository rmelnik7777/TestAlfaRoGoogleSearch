//
//  SearchListEventsHandler.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/3/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import Foundation


protocol SearchListEventsHandler {
    var view: SearchListView? { get set}
    
    func ready()
    func open(link: URL)
    func search (text: String, keyStop: Int)
    func stopSearch()

}


