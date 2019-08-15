//
//  Loader.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 8/15/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

protocol Loader {
    init(thread: String, container: Container<SearchListPresentationItem>)
    
    func start(text: String)
    func stop()
}
