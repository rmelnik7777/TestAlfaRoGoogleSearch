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
    var startForSearchPoint: String = "1"
    let queue = OperationQueue()

    func ready (){
    }

    func open(link: URL) {
        
    }
    func search(text: String, keyStop: Int) {

        let thread1 = BlockOperation()
        let thread2 = BlockOperation()
        
        thread1.addExecutionBlock {
            self.startSearch(startForSearchPoint: self.startForSearchPoint, text: text, tread: "thread_1")
            print(Thread.current)
            print("Начало поиска с - ", self.startForSearchPoint)
        }
        startForSearchPoint = String(Int(startForSearchPoint)! + 5)

        thread2.addExecutionBlock {
            self.startSearch(startForSearchPoint: self.startForSearchPoint, text: text, tread: "thread_2")
            print(Thread.current)
            print("Начало поиска с - ", self.startForSearchPoint)
        }
 
        
        queue.addOperation(thread1)
        queue.addOperation(thread2)
        

//        for _ in 1...3 {
//
//            thread1.addExecutionBlock {
//                self.startSearch(startForSearchPoint: startForSearchPoint, text: text, tread: "thread_1")
//                print(Thread.current)
//                print("Начало поиска с - ", startForSearchPoint)
//            }
//            if keyStop == 17 {
//                thread1.cancel()
//                print("it's all")
//                return
//            }
//            startForSearchPoint = String(Int(startForSearchPoint)! + 5)
//            queue.addOperation(thread1)
//        }
        
    }

    func stopSearch() {
        queue.cancelAllOperations()
        //self.search(text: " ", keyStop: 17)
        print("Функция остановки потоков запущена")
    }
    
    
    
    func startSearch(startForSearchPoint: String, text: String, tread: String){
        let fetchGoogleSearch = FetchGoogleSearch()
        fetchGoogleSearch.fetchGoogleSearch (startForSearchPoint: startForSearchPoint ,searchText: text, tread: tread) { [weak self] data in
            guard let self = self,
                let data = data else { return }
            let presentationData = data.map { googleData in
                return SearchListPresentationItem (title: googleData.title , url: googleData.link, image: googleData.image)
            }
            self.view?.update(items: presentationData)
        }
    }
}


//        let queue1 = DispatchQueue(label: "ThreadGey1", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: .none)
//        let queue2 = DispatchQueue.global(qos: .default)
//        var startForSearchPoint: String = "1"
//
//
//        for _ in 1...3 {
//            queue1.sync {
//                self.startSearch(startForSearchPoint: startForSearchPoint, text: text, tread: "thread_1")
//                print(Thread.current)
//                print("Начало поиска с - ", startForSearchPoint)
//            }
//            startForSearchPoint = String(Int(startForSearchPoint)! + 5)
//            queue2.sync {
//                self.startSearch(startForSearchPoint: startForSearchPoint, text: text, tread: "thread_2")
//                print(Thread.current)
//                print("Начало поиска с - ", startForSearchPoint)
//
//            }
//            startForSearchPoint = String(Int(startForSearchPoint)! + 5)
//            print("Начало поиска с - ", startForSearchPoint)
//        }





//        DispatchQueue.concurrentPerform(iterations: 4, execute: { i in
//            self.startSearch(startForSearchPoint: String (i), text: text, tread: "thread_1")
//            print(Thread.current)
//        })




//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        DispatchQueue.global().async {
//            print("Поток1 Южный централ")
//            self.startSearch(startForSearchPoint: "1", text: text, tread: "thread_1")
//            dispatchGroup.leave()
//        }
//
//        dispatchGroup.enter()
//        DispatchQueue.global().async {
//            let imageThread = "thread_2"
//            print("Поток2 Серверное Бутово")
//            self.startSearch(startForSearchPoint: "11", text: text, tread: imageThread)
//            dispatchGroup.leave()
//        }
//
//        dispatchGroup.notify(queue: .global()) {
//            print("Посасывая лапу у медведя на районе")
//        }


