//
//  Container.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 8/15/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import Foundation

class Container<T> {
    private let semaphore = DispatchSemaphore(value: 1)
    private var items = [T]()
    private var counter = 0
    private var handler: (([T])->())?
    
    func ifUpdate(handler: @escaping ([T])->()) {
        self.handler = handler
    }
    
    func clear() {
        semaphore.wait()
        counter = 1
        items = [T]()
        handler?(items)
        semaphore.signal()
    }
    
    func append(items: [T]) {
        semaphore.wait()
        self.items.append(contentsOf: items)
        handler?(items)
        semaphore.signal()
    }
    
    func reserve(count: Int) -> Int { // -> Start Index
        semaphore.wait()
        let oldValue = counter
        counter += count
        semaphore.signal()
        return oldValue
    }
}

