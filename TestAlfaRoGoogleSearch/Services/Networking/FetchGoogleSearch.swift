//
//  FetchGoogleSearch.swift
//  TestAlfaRoGoogleSearch
//
//  Created by Роман Мельник on 6/19/19.
//  Copyright © 2019 NGSE. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FetchGoogleSearch {
    public func fetchGoogleSearch(searchText: String? = nil, completion: (([GoogleData]?) -> Void)? = nil){
        let url = URL(string: "https://www.googleapis.com/customsearch/v1?")
        let startForSearchPoint = "1"
        let parameters = [
            "key": "AIzaSyB3YD_DYoLruCYPTR170RJ-Hd6mL1xa7gc",
            "q": searchText ?? "",
            "num": "10",
            "cx": "018374168168575018408:yxsv8t-uj2m",
            "hl": "ua",
            "start": startForSearchPoint
        ]
        
        
        
        Alamofire.request(url!, method: .get, parameters: parameters)
        //Alamofire.request(url!, method: .get, parameters: parameters)
            
            .validate()
            .responseString(completionHandler: { response in
            })
            .responseJSON { (response ) in
                switch response.result {
                case .success(let info):
                    // то что я добавил
                    
                    
                    // то покуда добавил

                    let json = JSON(info)
                    print(parameters)
                    var gData = [GoogleData]()
                    for item in json["items"].arrayValue {
                        let filterSearchData = GoogleData(title: item["title"].stringValue, link: item["link"].stringValue)
                        gData.append(filterSearchData)
                    }
    
                    completion?(gData)
                case .failure(let error):
                    print ("error while fetching data: \(error.localizedDescription)")
                    completion?(nil)
                    
                }
                
        }
    }
}
