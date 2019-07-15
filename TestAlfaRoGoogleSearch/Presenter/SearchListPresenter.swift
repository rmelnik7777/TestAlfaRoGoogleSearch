//
//  SearchListPresenter.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/19/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class SearchListPresenter: SearchListEventsHandler {
    weak var view: SearchListView?

    func ready (){
    }

    func open(link: URL) {
        
    }
    func search(text: String, keyStop: Int) {
        repeat {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DispatchQueue.global().async {
            print("Поток1 Южный централ")
            self.startSearch(startForSearchPoint: "1", text: text, tread: "thread_1")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            let imageThread = "thread_2"
            print("Поток2 Серверное Бутово")
            self.startSearch(startForSearchPoint: "11", text: text, tread: imageThread)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global()) {
            print("Посасывая лапу у медведя на районе")
        }
    } while keyStop != 30
        
    }

//    func search(text: String) {
//
//        print(text)
//        let fetchGoogleSearch = FetchGoogleSearch()
//        fetchGoogleSearch.fetchGoogleSearch (searchText: text) { [weak self] data in
//            guard let self = self,
//            let data = data else { return }
//
//            let presentationData = data.map { googleData in
//            return SearchListPresentationItem (title: googleData.title , url: googleData.link)
//            }
//            self.view?.update(items: presentationData)
//        }
//    }
    func stopSearch() {
        self.search(text: " ", keyStop: 30)
        print("STOoooooooooooooPed")
    }
    
    func startSearch(startForSearchPoint: String, text: String, tread: String){
        let fetchGoogleSearch = FetchGoogleSearch()
        fetchGoogleSearch.fetchGoogleSearch (startForSearchPoint: startForSearchPoint ,searchText: text, tread: tread) { [weak self] data in
            guard let self = self,
                let data = data else { return }
            print(data.count)
            let presentationData = data.map { googleData in
                return SearchListPresentationItem (title: googleData.title , url: googleData.link, image: googleData.image)
            }
            if data.count == 6 {
                self.stopSearch()
            }
            self.view?.update(items: presentationData)
        }
    }
    
}


