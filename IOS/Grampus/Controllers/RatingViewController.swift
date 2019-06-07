//
//  RatingViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

// like_best_looker

import UIKit
import Alamofire
import SwiftyJSON

class RatingViewController: UIViewController, ModalViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var _navigationBar: UINavigationBar!
    @IBOutlet weak var _menuBarButton: UIBarButtonItem!
    @IBOutlet weak var _searchBar: UISearchBar!
    @IBOutlet weak var _tableView: UITableView!

    // MARK: - Properties
    let API_URL = "\(dURL.dynamicURL.rawValue)profiles/all"
    
    var json = JSON()
    
    // MARK: - Functions
    
    override func loadView() {
        super.loadView()
        
        fetchAllUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _tableView.delegate = self
        _tableView.dataSource = self
        
        navBarAppearance()
        
        if revealViewController() != nil {
            _menuBarButton.target = self.revealViewController()
            _menuBarButton.action = #selector(SWRevealViewController().revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }
    
    func fetchAllUsers() {
        
        let def = UserDefaults.standard
        
        let token = def.string(forKey: userDefKeys.token.rawValue)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                
                if let result = responseJSON.result.value {
                    
                    
                    self.json = JSON(result)
                
                    print(self.json)
                    self._tableView.reloadData()
                }
                
            case .failure(let error) :
                print(error)
                
            }
        }
        
    }
    
    func navBarAppearance() {
        _navigationBar.barTintColor = UIColor.darkText
        _navigationBar.tintColor = UIColor.white
    }
    
    func chooseLikeOrDislike( bool: Bool ) {
        let def = UserDefaults.standard
        def.set(bool, forKey: userDefKeys.likeState.rawValue)
        def.synchronize()
    }
    
    // Actions
    @IBAction func likeButtonAction(_ sender: Any) {
        chooseLikeOrDislike( bool: true )
        
        self.performSegue(withIdentifier: "ShowModalView", sender: self)
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        self.overlayBlurredBackgroundView()
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
        chooseLikeOrDislike(bool: false)
        
        self.performSegue(withIdentifier: "ShowModalView", sender: self)
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        self.overlayBlurredBackgroundView()
    }
    
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .regular)
        
        view.addSubview(blurredBackgroundView)
        
    }
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowModalView" {
                if let viewController = segue.destination as? ModalViewController {
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                }
            }
        }
    }
    
    func saveSelectedUserId( selectedUserId: Int ) {
        let def = UserDefaults.standard
        def.set(selectedUserId, forKey: userDefKeys.selectedUserId.rawValue)
        def.synchronize()
    }
    
    @objc func buttonClicked(sender:UIButton) {
        let buttonRow = sender.tag
        print("BUTTON ROW ==============")
        print(buttonRow)
        
        if let id = self.json[buttonRow]["profileId"].int {
            print("selectedUserId ==============")
            print(id)
            saveSelectedUserId(selectedUserId: id)
        } else {
            print("HERE WE GO AGAIN 1")
        }
    }
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! RatingTableViewCell
        
        var userNameToDisplay = ""
        var jobTitleToDisplay = ""
        var likeDislikeButtonState = true
        
        if let id = self.json[indexPath.row]["profileId"].int {
            print(id)
        } else {
            print("HERE WE GO AGAIN 1")
        }
        
        if let userName = self.json[indexPath.row]["fullName"].string {
            print(userName)
            userNameToDisplay = userName
        } else {
            print("HERE WE GO AGAIN 2")
        }
        
        if let jobTitle = self.json[indexPath.row]["jobTitle"].string {
            jobTitleToDisplay = jobTitle
            print(jobTitle)
        } else {
            print("HERE WE GO AGAIN 3")
        }
        
        if let profilePicture = self.json[indexPath.row]["picture"].string {
            print(profilePicture)
        } else {
            print("HERE WE GO AGAIN 4")
        }
        
        if let isAbleToLike = self.json[indexPath.row]["isAbleToLike"].bool {
            print("IS ABLE TO LIKE -------------------------------")
            print(isAbleToLike)
            likeDislikeButtonState = isAbleToLike
        } else {
            print("HERE WE GO AGAIN 5")
        }
        
        print("likeDislikeButtonState -------------------------------")
        print(likeDislikeButtonState)
        
        if likeDislikeButtonState {
            cell._likeButton.isEnabled = true
            cell._dislikeButton.isEnabled = true
        } else {
            cell._likeButton.isEnabled = false
            cell._dislikeButton.isEnabled = false
        }
        
        DispatchQueue.main.async {
            cell._nameLabelCell.text = userNameToDisplay
            cell._professionLabelCell.text = jobTitleToDisplay
        }
        
        cell._likeButton.tag = indexPath.row
        cell._likeButton.addTarget(self, action: #selector(self.buttonClicked), for: UIControl.Event.touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let id = self.json[indexPath.row]["profileId"].int {
            print("IDDDDDDDDDDD \(id)")
            let def = UserDefaults.standard
            def.set("\(id)", forKey: userDefKeys.selectedUserIdProfile.rawValue)
            def.set(false, forKey: userDefKeys.profileState.rawValue)
            def.synchronize()
            
            self.performSegue(withIdentifier: segueIdentifier.rating_to_selected_profile.rawValue, sender: self)
        } else {
            print("HERE WE GO AGAIN 1")
        }
    }
    
}
