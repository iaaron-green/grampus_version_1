//
//  Utilities.swift
//  Grampus
//
//  Created by Тимур Кошевой on 6/12/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import Foundation
import Alamofire

class Fetch {
    
    static let shared = Fetch()
    let pieVC = PieChartViewController()
    
    func fetchAchievements(userId: String) {
        
        let def = UserDefaults.standard
        let token = def.string(forKey: userDefKeys.token.rawValue)
        print(token!)
        
        var achievements: NSDictionary!
        
        let API_URL: String = "\(dURL.dynamicURL.rawValue)profiles/\(userId)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        print("BEFORE")
        Alamofire.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            print("IN")

            switch responseJSON.result {
            case .success :
                
                if let result = responseJSON.result.value {
                    
                    let json = result as! NSDictionary
                
                    print("NSDictionary")
                    print(json)

                    
                    achievements = json["achievements"] as? NSDictionary
                    self.pieVC.achievements = achievements
                    print("NSDictionary")
                    print(json)
                    print("achievements!!!!!!!!!!!!!!!!!!!")
                    print(achievements)
                    print("end!!!!!!!!!!!!!!!!!!!")
                    
                }
                
            case .failure(let error) :
                print(error)
                
                achievements = ["empty": "true"]
            }
        }
        print("AFTER")
        
    }
    
}
