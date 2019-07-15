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
    public func fetchGoogleSearch(startForSearchPoint: String = "1", searchText: String? = nil,tread:String, completion: (([GoogleData]?) -> Void)? = nil){
        let url = URL(string: "https://www.googleapis.com/customsearch/v1?")
        let parameters = [
            "key": "AIzaSyB3YD_DYoLruCYPTR170RJ-Hd6mL1xa7gc",
            "q": searchText ?? "",
            "num": "1",
            "cx": "018374168168575018408:yxsv8t-uj2m",
            "hl": "ru",
            "start": startForSearchPoint
        ]
        
        Alamofire.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseString(completionHandler: { response in
            })


            .responseJSON { (response ) in
                switch response.result {
                case .success(let info):
                    let json = JSON(info)
                    var gData = [GoogleData]()
                    for item in json["items"].arrayValue {
                        let filterSearchData = GoogleData(title: item["title"].stringValue, link: item["link"].stringValue, image: tread )
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
