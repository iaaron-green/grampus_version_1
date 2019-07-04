//
//  MenuTableViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import Alamofire

class MenuTableViewController: UITableViewController {
    
    
    @IBOutlet weak var _imageView: UIImageView!
    @IBOutlet weak var _fullName: UILabel!
    @IBOutlet weak var _emailLabel: UILabel!
    
    var profilePicture: String?
    var fullName: String?
    var email: String?
    
    override func loadView() {
        super.loadView()
        
        fetchUserInformation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.tableView.separatorStyle = .none
        
        // preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        tableView.reloadData()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchUserInformation() {
        
        let def = UserDefaults.standard
        
        let token = def.string(forKey: userDefKeys.token.rawValue)
        let userId = def.string(forKey: userDefKeys.userId.rawValue)
        
        let API_URL: String = "\(dURL.dynamicURL.rawValue)profiles/\(userId!)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                
                if let result = responseJSON.result.value {
                    
                    let JSON = result as! NSDictionary
                    let profile = JSON["profile"] as! NSDictionary
                    let user = profile["user"] as! NSDictionary
                    
                    self.fullName = user["fullName"] as? String
                    self.email = user["username"] as? String
                    self.profilePicture = profile["profilePicture"] as? String
                    
                    if let unwrappedFullName = self.fullName {
                        self.fullName = unwrappedFullName
                    } else {
                        self.fullName = "Full Name"
                    }
                    
                    if let unwrappedEmail = self.email {
                        self.email = unwrappedEmail
                    } else {
                        self.email = "email"
                    }
                    
                    if let unwrappedProfilePicture = self.profilePicture {
                        self.profilePicture = unwrappedProfilePicture
                    } else {
                        self.profilePicture = "some base64"
                    }
                    
                    self._fullName.text = self.fullName!
                    self._emailLabel.text = self.email!
                    self.tableView.reloadData()
                }
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            let def = UserDefaults.standard
            def.set(true, forKey: userDefKeys.profileState.rawValue)
        }
        if indexPath.row == 6 {
            saveLoggedState()
            saveUserToken()
        }
    }
    
    func saveLoggedState() {
        let def = UserDefaults.standard
        def.set(false, forKey: userDefKeys.isLoggedIn.rawValue)
        def.synchronize()
    }
    
    func saveUserToken() {
        let def = UserDefaults.standard
        def.set("", forKey: userDefKeys.token.rawValue)
        def.synchronize()
    }
    
}
