//
//  Storage.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 7/16/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import SQLite
class Storage {
    //static let shared = Database()
    public let connection: Connection?
    private init(){
        do {
            let dbPath = Bundle.main.path(forResource: "tableVukalovich", ofType: "db")!
            connection = try Connection(dbPath)
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database. Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}
