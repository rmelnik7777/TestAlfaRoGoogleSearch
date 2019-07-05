//
//  SearchListPresenterMock.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/3/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import Foundation

class SearchListPresenterMock: SearchListEventsHandler {
    
    weak var view: SearchListView?
    
    func ready() {
        let item1 = SearchListPresentationItem (title: "Cat", url: "https://www.youtube.com/watch?v=JtDf-S1uLLs")
        let item2 = SearchListPresentationItem (title: "Dog", url: "https://google.com")
        let item3 = SearchListPresentationItem (title: "London", url: "https://www.youtube.com")
        let item4 = SearchListPresentationItem (title: "Alibaba", url: "https://www.duolingo.com")
        let item5 = SearchListPresentationItem (title: "World", url: "https://lingualeo.com/")
        let item6 = SearchListPresentationItem (title: "Liashko", url: "http://www.multitran.ru/")
        let item7 = SearchListPresentationItem (title: "Armen", url: "https://uk.glosbe.com/")
        let item8 = SearchListPresentationItem (title: "QOS", url: "https://translate.google.ru/")
        view?.update(items: [item1,item2,item3,item4,item5,item6,item7,item8])
    }
    
    func open(link: URL) {
        
    }
    
    func search(text: String) {
         print("searchhhhh", text)
        
    }
    
    func stopSearch() {
        print("Нажата кнопка")
    }
    
    
}
