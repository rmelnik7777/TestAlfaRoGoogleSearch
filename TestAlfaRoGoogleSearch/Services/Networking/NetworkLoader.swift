//
//  NetworkLoader.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 8/15/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import  Alamofire
import Foundation
import SwiftyJSON

class NetworkLoader: Loader {
    enum Constants {
        static let url = URL(string: "https://www.googleapis.com/customsearch/v1?")
        static let maxResult = 30
        static let stepSearch = 5
    }
    
    private let thread: String
    private let container: Container<SearchListPresentationItem>
    
    private let queue = DispatchQueue.global(qos: .default)
    private var currentWorkItem: DispatchWorkItem?
    
    required init(thread: String, container: Container<SearchListPresentationItem>) {
        self.thread = thread
        self.container = container
    }
    
    func start(text: String) {
        currentWorkItem = DispatchWorkItem(qos: .background) { [weak self] in
            self?.perform(text: text)
        }
        next()
    }
    
    func stop() {
        currentWorkItem?.cancel()
        currentWorkItem = nil
    }
}

extension NetworkLoader{
    func next() {
        guard let workItem = currentWorkItem,
            !workItem.isCancelled else { return }
        
        queue.async(execute: workItem)
    }
    
    func perform(text: String) {
        
//        simulateCalculation() // imitation delay
        
        let startIndex = container.reserve(count: Constants.stepSearch)
        guard startIndex <= Constants.maxResult else {
            stop()
            return
        }
        
        guard let workItem = currentWorkItem else { return }
        
        let parameters = [
            "key": "AIzaSyB3YD_DYoLruCYPTR170RJ-Hd6mL1xa7gc",
//            "key": "AIzaSyDpE26jqGu1lAQazkFJ8Oh6I5_qSXkGlZ4",
            "q": text,
            "num": String(Constants.stepSearch),
            "cx": "018374168168575018408:yxsv8t-uj2m",
//            "cx": "007379028434554645740:f_rv9myd8ke",
            "hl": "ru",
            "start": String(startIndex)
        ]
        print("🐡🐡🐡🐡🐡\(startIndex)")
        guard !workItem.isCancelled else { return }
        print("🐷🐷🐷🐷🐷 номер потока - ", Thread.current, "🦍🦍🦍🦍🦍")
        Alamofire.request(Constants.url!, method: .get, parameters: parameters)
            .validate()
            .responseString(completionHandler: { response in
            })
            .responseJSON { (response ) in
                var items = [SearchListPresentationItem]()
                switch response.result {
                case .success(let info):
                    let json = JSON(info)
                    for item in json["items"].arrayValue {
                        let filterSearchData = GoogleData(title: item["title"].stringValue, url:item["link"].stringValue, image: self.thread )
                        items.append(SearchListPresentationItem(title: filterSearchData.title, url: filterSearchData.url, image: filterSearchData.image))
                    }
                case .failure(let error):
                    print ("error while fetching data: \(error.localizedDescription)")
                }
                guard !workItem.isCancelled else { return }
                DispatchQueue.main.async {
                    self.container.append(items: items)
                }
                self.next()
        }
    }
    
//    private func simulateCalculation() {
//        let delay = UInt32.random(in: 1..<7)
//        sleep(delay)
//    }
}
