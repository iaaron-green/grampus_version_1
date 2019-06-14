//
//  ProfileTableViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/23/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import Alamofire
import Charts

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
    
    //Chart cell
    @IBOutlet weak var chartView: PieChartView!
    
    let alert = AlertView()
    let menuVC = MenuTableViewController()
    
    var fullName: String?
    var email: String?
    var profession: String?
    var likes: Int?
    var dislikes: Int?
    var information: String?
    var skills: String?
    var achievements: String?
    var profilePicture: String?
    var bestLooker: Int?
    var superWorker: Int?
    var untidy: Int?
    var deadLiner: Int?
    var extrovert: Int?
    var introvert: Int?
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadChart"), object: nil)
        
        //self.tableView.tableFooterView = UIView(frame: .zero)
        
        _navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        if revealViewController() != nil {
            _menuBarButton.target = self.revealViewController()
            _menuBarButton.action = #selector(SWRevealViewController().revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
//        setUpCharts()
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        let def = UserDefaults.standard
        def.set(true, forKey: userDefKeys.profileState.rawValue)
    }
    
    
    @objc func loadList(notification: NSNotification){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
                    let achievements = json["achievements"] as! NSDictionary
                    let user = profile["user"] as! NSDictionary
                    
                    print("NSDictionary")
                    print(json)
                    print("USER")
                    print(user)
                    print("achievements!!!!!!!!!!!!!!!!!!!")
                    print(achievements)
                    print("end!!!!!!!!!!!!!!!!!!!")

                    self.fullName = user["fullName"] as? String
                    self.profession = user["jobTitle"] as? String
                    self.email = user["username"] as? String
                    self.likes = profile["likes"] as? Int
                    self.dislikes = profile["dislikes"] as? Int
                    self.information = profile["information"] as? String
                    self.skills = profile["skills"] as? String
                    
                    self.bestLooker = achievements["best_looker"] as? Int
                    self.superWorker = achievements["super_worker"] as? Int
                    self.extrovert = achievements["extrovert"] as? Int
                    self.untidy = achievements["untidy"] as? Int
                    self.deadLiner = achievements["deadliner"] as? Int
                    self.introvert = achievements["introvert"] as? Int

                   
                    if let unwrappedbestLooker = self.bestLooker {
                        self.bestLooker = unwrappedbestLooker
                    } else {
                        self.bestLooker = 0
                    }
                    
                    if let unwrappedsuperWorker = self.superWorker {
                        self.superWorker = unwrappedsuperWorker
                    } else {
                        self.superWorker = 0
                    }
                    
                    if let unwrappedextrovert = self.extrovert {
                        self.extrovert = unwrappedextrovert
                    } else {
                        self.extrovert = 0
                    }
                    
                    if let unwrappeduntidy = self.untidy {
                        self.untidy = unwrappeduntidy
                    } else {
                        self.untidy = 0
                    }
                    
                    if let unwrappeddeadLiner = self.deadLiner {
                        self.deadLiner = unwrappeddeadLiner
                    } else {
                        self.deadLiner = 0
                    }
                    
                    if let unwrappedintrovert = self.introvert {
                        self.introvert = unwrappedintrovert
                    } else {
                        self.introvert = 0
                    }
                    
                    print(self.bestLooker!)
                    print(self.superWorker!)
                    
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
                    
                    self.setUpCharts()
                    self.tableView.reloadData()
                }
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    func setUpCharts() {
        
        chartView.chartDescription?.enabled = false
        chartView.drawHoleEnabled = false
        chartView.rotationAngle = 0
        chartView.rotationEnabled = false
        chartView.isUserInteractionEnabled = false

        var bestLookerColor = UIColor.clear
        var superWorkerColor = UIColor.clear
        var extrovertColor = UIColor.clear
        var untidyColor = UIColor.clear
        var deadLinerColor = UIColor.clear
        var introvertColor = UIColor.clear
        
        var entries: [PieChartDataEntry] = []
        var colorArray: [UIColor] = []
        
        if self.bestLooker! != 0 {
            entries.append(PieChartDataEntry(value: Double(self.bestLooker!), label: "\(self.bestLooker!)"))
            bestLookerColor = UIColor.cyan
            colorArray.append(bestLookerColor)
        }
        
        if self.superWorker! != 0 {
            entries.append(PieChartDataEntry(value: Double(self.superWorker!), label: "\(self.superWorker!)"))
            superWorkerColor = UIColor.red
            colorArray.append(superWorkerColor)
        }
        
        if self.extrovert! != 0 {
            entries.append(PieChartDataEntry(value: Double(self.extrovert!), label: "\(self.extrovert!)"))
            extrovertColor = UIColor.blue
            colorArray.append(extrovertColor)
        }
        
        if self.untidy! != 0 {
            entries.append(PieChartDataEntry(value: Double(self.untidy!), label: "\(self.untidy!)"))
            untidyColor = UIColor.gray
            colorArray.append(untidyColor)
        }
        
        if self.deadLiner! != 0 {
            entries.append(PieChartDataEntry(value: Double(self.deadLiner!), label: "\(self.deadLiner!)"))
            deadLinerColor = UIColor.black
            colorArray.append(deadLinerColor)
        }
        
        if self.introvert! != 0 {
            entries.append(PieChartDataEntry(value: Double(self.introvert!), label: "\(self.introvert!)"))
            introvertColor = UIColor.brown
            colorArray.append(introvertColor)
        }
        
        print(entries)
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = colorArray
        dataSet.drawValuesEnabled = false
        chartView.data = PieChartData(dataSet: dataSet)
        
    }
    
    func setUpProfile( fullName: String, profession: String, likes: Int, dislikes: Int, information: String, skills: String) {
        
        _profileFullNameLabel.text = fullName
        _profileProfessionLabel.text = profession
        _profileLikeLabel.text = "Likes: \(String(describing: likes))"
        _profileDislikeLabel.text = "Dislikes: \(String(describing: dislikes))"
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
        print(token)
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
