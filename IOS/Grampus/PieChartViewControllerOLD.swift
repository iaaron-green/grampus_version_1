//
//  ViewController.swift
//  Pie Chart View
//
//

import UIKit
import Alamofire

class PieChartViewController : UIViewController {
    
    let pieChartView = PieChartViewO()
    let simplePieChartView = SimplePieChartView()
    
    var achievements: NSDictionary = ["empty": "true"]
    
    var bestLooker: Int?
    var superWorker: Int?
//    var extrovert: Int?
//    var untidy: Int?
//    var deadLiner: Int?
//    var introvert: Int?
    
//    var bestLooker = 1
//    var superWorker = 1
    var extrovert = 1
    var untidy = 1
    var deadLiner = 1
    var introvert = 1
//    let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        super.loadView()
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    }
    
    
    func try1337() {
        let def = UserDefaults.standard
        let userId = def.string(forKey: userDefKeys.userId.rawValue)
        let selectedUserIdProfile = def.string(forKey: userDefKeys.selectedUserIdProfile.rawValue)
        let profileState = def.bool(forKey: userDefKeys.profileState.rawValue)
        
        if profileState {
            Fetch.shared.fetchAchievements(userId: userId!)
        } else {
            Fetch.shared.fetchAchievements(userId: selectedUserIdProfile!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        parseAchievements()
        setUpChart()

    }
    
//    func parseAchievements() {
//
//        let def = UserDefaults.standard
//        let userId = def.string(forKey: userDefKeys.userId.rawValue)
//        let selectedUserIdProfile = def.string(forKey: userDefKeys.selectedUserIdProfile.rawValue)
//        let profileState = def.bool(forKey: userDefKeys.profileState.rawValue)
//
//        var API_URL: String = "\(dURL.dynamicURL.rawValue)profiles/\(userId)"
//
//        if profileState {
////            Fetch.shared.fetchAchievements(userId: userId!)
//            API_URL = "\(dURL.dynamicURL.rawValue)profiles/\(userId)"
//        } else {
////            Fetch.shared.fetchAchievements(userId: selectedUserIdProfile!)
//            API_URL = "\(dURL.dynamicURL.rawValue)profiles/\(selectedUserIdProfile)"
//        }
//
//        let token = def.string(forKey: userDefKeys.token.rawValue)
//        print(token!)
//
//        var achievements: NSDictionary!
//
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json; charset=utf-8",
//            "Authorization": "Bearer \(token!)"
//        ]
//
//        print("BEFORE")
//        Alamofire.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
//
//            switch responseJSON.result {
//            case .success :
//
//                if let result = responseJSON.result.value {
//
//                    let json = result as! NSDictionary
//
//                    print("NSDictionary")
//                    print(json)
//
//
//                    achievements = json["achievements"] as? NSDictionary
//                    self.achievements = achievements
//                    print("NSDictionary")
//                    print(json)
//                    print("achievements!!!!!!!!!!!!!!!!!!!")
//                    print(achievements)
//                    print("end!!!!!!!!!!!!!!!!!!!")
//
//                }
//
//            case .failure(let error) :
//                print(error)
//
//                achievements = ["empty": "true"]
//            }
//        }
//
//
//        bestLooker = achievements["best_looker"] as? Int
//
//        if let unwrappedbestLooker = self.bestLooker {
//            self.bestLooker = unwrappedbestLooker
//        } else {
//            self.bestLooker = 1
//        }
//
//        superWorker = achievements["super_worker"] as? Int
//
//        if let unwrappedSuperWorker = self.superWorker {
//            self.superWorker = unwrappedSuperWorker
//        } else {
//            self.superWorker = 1
//        }
//
//        extrovert = achievements["extrovert"] as? Int
//
//        if let unwrappedExtrovert = self.extrovert {
//            self.extrovert = unwrappedExtrovert
//        } else {
//            self.extrovert = 1
//        }
//
//        untidy = achievements["untidy"] as? Int
//
//        if let unwrappedUntidy = self.untidy {
//            self.untidy = unwrappedUntidy
//        } else {
//            self.untidy = 1
//        }
//
//        deadLiner = achievements["deadLiner"] as? Int
//
//        if let unwrappedDeadLiner = self.deadLiner {
//            self.deadLiner = unwrappedDeadLiner
//        } else {
//            self.deadLiner = 1
//        }
//
//        introvert = achievements["introvert"] as? Int
//
//        if let unwrappedIntrovert = self.introvert {
//            self.introvert = unwrappedIntrovert
//        } else {
//            self.introvert = 1
//        }
//
//
//    }
    
    func setUpChart() {
        
        
        let padding: CGFloat = 20
        let height = (view.frame.height - padding * 3) / 2
        
        pieChartView.frame = CGRect(
            x: 0, y: padding, width: view.frame.size.width, height: height
        )
        

        
        let def = UserDefaults.standard
        self.bestLooker = def.integer(forKey: "bestLooker")
        self.superWorker = def.integer(forKey: "superWorker")
        print(bestLooker!)
        print(superWorker!)

        pieChartView.segments = [
            LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "",  value: CGFloat(bestLooker!)),    //Red -
            LabelledSegment(color: #colorLiteral(red: 1, green: 0.541176471, blue: 0, alpha: 1), name: "",  value: CGFloat(superWorker!)),    //Orange
            LabelledSegment(color: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), name: "",  value: CGFloat(extrovert)),    //Purple
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "",  value: CGFloat(untidy)),    //Light Blue
            LabelledSegment(color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), name: "",  value: CGFloat(deadLiner)),    //Green
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "",  value: CGFloat(introvert))     //Blue
        ]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadChart"), object: nil)
        
        pieChartView.segmentLabelFont = .systemFont(ofSize: 10)
        
        view.addSubview(pieChartView)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadChart"), object: nil)
        
    }
    
}

