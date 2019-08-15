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
import RealmSwift

class SearchListPresenter: SearchListEventsHandler {
    weak var view: SearchListView?
    let container = Container<SearchListPresentationItem>()
    lazy var loader1: Loader = NetworkLoader(thread: "thread_1", container: container)
    lazy var loader2: Loader = NetworkLoader(thread: "thread_2", container: container)
    
    init() {
        container.ifUpdate { items in
            self.view?.update(items: items)
        }
    }
    
    func ready (){
    }

    func search(text: String) {
        container.clear()
        loader1.start(text: text)
        loader2.start(text: text)

    }
    
    func stopSearch() {
        loader1.stop()
        loader2.stop()
    }
}

    
    
//    func startSearch(startForSearchPoint: String, text: String, tread: String){
//        let fetchGoogleSearch = FetchGoogleSearch()
//        fetchGoogleSearch.fetchGoogleSearch (startForSearchPoint: startForSearchPoint ,searchText: text, tread: tread) { [weak self] data in
//            guard let self = self,
//                let data = data else { return }
//            let presentationData = data.map { googleData in
//                return SearchListPresentationItem (title: googleData.title , url: googleData.link, image: googleData.image)
//            }
//            self.view?.update(items: presentationData)
//        }
//    }
//}





//    func search(text: String) {
//        queue.maxConcurrentOperationCount = 2
//        enableSearch = true
//
//
//        print(enableSearch)
//        if enableSearch == false {
//            let thread1 = {
//                self.startSearch(startForSearchPoint: self.startForSearchPoint, text: text, tread: "thread_1")
//                    print("номер потока - ", Thread.current, "Начало поиска с - ", self.startForSearchPoint)
//                    self.startForSearchPoint = String(Int(self.startForSearchPoint)! + 5)
//                }
//                queue.addOperation(thread1)
//        }
//            print(enableSearch)
//            if enableSearch == true {
//                let thread2 = {
//                    self.startSearch(startForSearchPoint: self.startForSearchPoint, text: text, tread: "thread_2")
//                    print("номер потока - ", Thread.current, "Начало поиска с - ", self.startForSearchPoint)
//                    self.startForSearchPoint = String(Int(self.startForSearchPoint)! + 5)
//                }
//                queue.addOperation(thread2)
//            } else {return}
//            print(enableSearch)
//
//   }



//let queue1 = DispatchQueue(label: "ThreadGey1", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: .none)
//let queue2 = DispatchQueue.global(qos: .default)
//
//queue1.async {
//
//    self.startSearch(startForSearchPoint: startForSearchPoint, text: text, tread: "thread_1")
//    print("номер потока - ", Thread.current, "Начало поиска с - ", startForSearchPoint)
//    startForSearchPoint = String(Int(startForSearchPoint)! + 5)
//}
//queue2.async {
//    self.startSearch(startForSearchPoint: startForSearchPoint, text: text, tread: "thread_2")
//    print("номер потока - ", Thread.current, "Начало поиска с - ", startForSearchPoint)
//    startForSearchPoint = String(Int(startForSearchPoint)! + 5)
//}
