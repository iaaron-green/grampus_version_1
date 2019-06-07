//
//  ProfileTableViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/23/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import Alamofire

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var _menuBarButton: UIBarButtonItem!
    @IBOutlet weak var _navigationBar: UINavigationBar!
    
    //Overview cell
    @IBOutlet weak var _profileImageView: UIImageView!
    @IBOutlet weak var _profileFullNameLabel: UILabel!
    @IBOutlet weak var _profileProfessionLabel: UILabel!
    @IBOutlet weak var _profileLikeLabel: UILabel!
    @IBOutlet weak var _profileDislikeLabel: UILabel!
    
    //Achievement cell
    
    //Information cell
    @IBOutlet weak var _profileInformationLabel: UILabel!
    @IBOutlet weak var _infoAddButton: UIButton!
    
    //Skills cell
    @IBOutlet weak var _profileSkillsLabel: UILabel!
    @IBOutlet weak var _skillsAddButton: UIButton!
    
    let alert = AlertView()
    let menuVC = MenuTableViewController()
    let pieChartViewController = PieChartViewController()
    
    var fullName: String?
    var email: String?
    var profession: String?
    var likes: Int?
    var dislikes: Int?
    var information: String?
    var skills: String?
    var achievements: String?
    var profilePicture: String?
    
    //Pie chart
    var bestLooker = 1
    var superWorker = 2
    var extrovert = 3
    var untidy = 4
    var deadLiner = 5
    var introvert = 6
    
    override func loadView() {
        super.loadView()
        
        let def = UserDefaults.standard
        let userId = def.string(forKey: userDefKeys.userId.rawValue)
        let selectedUserIdProfile = def.string(forKey: userDefKeys.selectedUserIdProfile.rawValue)
        let profileState = def.bool(forKey: userDefKeys.profileState.rawValue)
        
        if profileState {
            fetchUserInformation(userId: userId!)
        } else {
            _infoAddButton.isEnabled = false
            _skillsAddButton.isEnabled = false
            fetchUserInformation(userId: selectedUserIdProfile!)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarAppearance()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        //self.tableView.tableFooterView = UIView(frame: .zero)
        
        _navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        if revealViewController() != nil {
            _menuBarButton.target = self.revealViewController()
            _menuBarButton.action = #selector(SWRevealViewController().revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        let def = UserDefaults.standard
        def.set(true, forKey: userDefKeys.profileState.rawValue)
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
                    let profile = json["profile"] as! NSDictionary
                    let user = profile["user"] as! NSDictionary
                    
                    print("NSDictionary")
                    print(json)
                    print("USER")
                    print(user)
                    
                    self.fullName = user["fullName"] as? String
                    self.profession = user["jobTitle"] as? String
                    self.email = user["username"] as? String
                    self.likes = profile["likes"] as? Int
                    self.dislikes = profile["dislikes"] as? Int
                    self.information = profile["information"] as? String
                    self.skills = profile["skills"] as? String
                    
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
                    
                    if let unwrappedProfession = self.profession {
                        self.profession = unwrappedProfession
                    } else {
                        self.profession = "Job Title"
                    }
                    
                    if let unwrappedLikes = self.likes {
                        self.likes = unwrappedLikes
                    } else {
                        self.likes = 0
                    }
                    
                    if let unwrappedDislikes = self.dislikes {
                        self.dislikes = unwrappedDislikes
                    } else {
                        self.dislikes = 0
                    }
                    
                    if let unwrappedInformation = self.information {
                        self.information = unwrappedInformation
                    } else {
                        self.information = "Information"
                    }
                    
                    if let unwrappedSkills = self.skills {
                        self.skills = unwrappedSkills
                    } else {
                        self.skills = "Skills"
                    }
                    
                    
                    
                    self.setUpProfile(fullName: self.fullName!, profession: self.profession!, likes: self.likes!, dislikes: self.dislikes!, information: self.information!, skills: self.skills!)
                }
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    func setUpProfile( fullName: String, profession: String, likes: Int, dislikes: Int, information: String, skills: String) {
        
        _profileFullNameLabel.text = fullName
        _profileProfessionLabel.text = profession
        _profileLikeLabel.text = "Likes: \(String(describing: likes))"
        _profileDislikeLabel.text = "Disikes: \(String(describing: dislikes))"
        _profileInformationLabel.text = information
        _profileSkillsLabel.text = skills
        self.tableView.reloadData()
    }
    
    func navBarAppearance() {
        _profileImageView.layer.cornerRadius = 50
        _profileImageView.layer.borderWidth = 1.5
        _profileImageView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // MARK: - Actions
    @IBAction func informationAddAction(_ sender: Any) {
        let alert = UIAlertController(title: "Enter information about yourself:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = self._profileInformationLabel.text
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.editProfileText(key: "information", text: textField?.text ?? "No info")
            self._profileInformationLabel.text = textField?.text
            self.tableView.reloadData()
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    @IBAction func skillsAddAction(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your skills:", message: nil, preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            textField.text = self._profileSkillsLabel.text
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.editProfileText(key: "skills", text: textField?.text ?? "No skiils")
            self._profileSkillsLabel.text = textField?.text
            self.tableView.reloadData()
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    func editProfileText( key: String, text: String) {
        
        let def = UserDefaults.standard
        let token = def.string(forKey: userDefKeys.token.rawValue)
        let API_URL: String = "\(dURL.dynamicURL.rawValue)profiles/"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        let body: [String : Any] = [
            key: text
        ]
        
        Alamofire.request(API_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                
                self.tableView.reloadData()
                
            case .failure(let error) :
                print(error)
            }
        }
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 3 {
            return UITableView.automaticDimension
        } else if indexPath.row == 4{
            return 300.0
        } else {
            return 120.0
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 3 {
            return UITableView.automaticDimension
        } else {
            return 120.0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
//                    if let unwrappedBestLooker = self.bestLooker {
//                        self.bestLooker = unwrappedBestLooker
//                    } else {
//                        self.bestLooker = 0
//                    }
//
//                    if let unwrappedSuperWorker = self.superWorker {
//                        self.superWorker = unwrappedSuperWorker
//                    } else {
//                        self.superWorker = 0
//                    }
//
//                    if let unwrappedLikes = self.extrovert {
//                        self.extrovert = unwrappedLikes
//                    } else {
//                        self.extrovert = 0
//                    }
//
//                    if let unwrappedLikes = self.untidy {
//                        self.untidy = unwrappedLikes
//                    } else {
//                        self.untidy = 0
//                    }
//
//                    if let unwrappedLikes = self.deadLiner {
//                        self.deadLiner = unwrappedLikes
//                    } else {
//                        self.deadLiner = 0
//                    }
//
//                    if let unwrappedLikes = self.introvert {
//                        self.introvert = unwrappedLikes
//                    } else {
//                        self.introvert = 0
//                    }
