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
        let item1 = SearchListPresentationItem (searchText: "cat", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item2 = SearchListPresentationItem (searchText: "dog", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item3 = SearchListPresentationItem (searchText: "london", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item4 = SearchListPresentationItem (searchText: "TT", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item5 = SearchListPresentationItem (searchText: "world", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item6 = SearchListPresentationItem (searchText: "Liashko", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item7 = SearchListPresentationItem (searchText: "Armen", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        let item8 = SearchListPresentationItem (searchText: "doll", url: URL(string: "https://www.youtube.com/watch?v=JtDf-S1uLLs")!)
        view?.update(items: [item1,item2,item3,item4,item5,item6,item7,item8])
    }
    
    func open(link: URL) {
    }
    
    func search(text: String) {
    }
    
    func stopSearch() {
    }
    
    
}
