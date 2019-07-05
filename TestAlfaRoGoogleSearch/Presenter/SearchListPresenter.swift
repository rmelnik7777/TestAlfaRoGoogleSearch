//
//  SearchListPresenter.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/19/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import Foundation
import Alamofire

class SearchListPresenter: SearchListEventsHandler {
    weak var view: SearchListView?
    
    func ready (){
    }

    func open(link: URL) {
        
    }
    
    func search(text: String) {
        print(text)
        let fetchGoogleSearch = FetchGoogleSearch()
        fetchGoogleSearch.fetchGoogleSearch (searchText: text) { [weak self] data in
            guard let self = self,
            let data = data else { return }
            
            let presentationData = data.map { googleData in
            return SearchListPresentationItem (title: googleData.title , url: googleData.link)
            }
            self.view?.update(items: presentationData)
        }
    }
    func stopSearch() {
    }
    
}


