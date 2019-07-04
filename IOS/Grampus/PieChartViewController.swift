//
//  ViewController.swift
//  Pie Chart View
//
//

import UIKit
import Alamofire

class PieChartViewController : UIViewController {
    
    let pieChartView = PieChartView()
    let simplePieChartView = SimplePieChartView()
    
    var bestLooker: Int?
    var superWorker: Int?
    let extrovert = 3
    let untidy = 4
    let deadLiner = 5
    let introvert = 6
    
//    var extrovert: Int?
//    var untidy: Int?
//    var deadLiner: Int?
//    var introvert: Int?
    
    override func loadView() {
        super.loadView()
        
        let def = UserDefaults.standard
        let userId = def.string(forKey: userDefKeys.userId.rawValue)
        let selectedUserIdProfile = def.string(forKey: userDefKeys.selectedUserIdProfile.rawValue)
        let profileState = def.bool(forKey: userDefKeys.profileState.rawValue)
        
        if profileState {
            fetchUserInformation(userId: userId!)
        } else {
            fetchUserInformation(userId: selectedUserIdProfile!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChart()
    }
    
    func fetchUserInformation(userId: String) {
        
        let def = UserDefaults.standard
        let token = def.string(forKey: userDefKeys.token.rawValue)
        print(token!)
        
        let API_URL: String = "\(dURL.dynamicURL.rawValue)profiles/\(userId)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                
                if let result = responseJSON.result.value {
                    
                    let json = result as! NSDictionary
                    let achievements = json["achievements"] as! NSDictionary
                    
                    print("NSDictionary")
                    print(json)
                    print("achievements!!!!!!!!!!!!!!!!!!!")
                    print(achievements)
                    print("end!!!!!!!!!!!!!!!!!!!")
                    
                }
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    func setUpChart() {
        
        let padding: CGFloat = 20
        let height = (view.frame.height - padding * 3) / 2
        
        pieChartView.frame = CGRect(
            x: 0, y: padding, width: view.frame.size.width, height: height
        )
        
        print(bestLooker)
        print(superWorker)
        
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
        
        simplePieChartView.frame = CGRect(
            x: 0, y: height + padding * 2,
            width: view.frame.size.width, height: height
        )
        
        simplePieChartView.segments = [
            Segment(color: .red,    value: 57),
            Segment(color: .blue,   value: 30),
            Segment(color: .green,  value: 25),
            Segment(color: .yellow, value: 40)
        ]
        view.addSubview(simplePieChartView)
    }
    
}

