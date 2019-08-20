//
//  SearchListPresenter.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/19/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import UIKit

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
