//
//  ModalViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 6/5/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import Alamofire

protocol ModalViewControllerDelegate: class {
    func removeBlurredBackgroundView()
}

class ModalViewController: UIViewController {
    
    @IBOutlet weak var _firstButton: UIButton!
    @IBOutlet weak var _secondButton: UIButton!
    @IBOutlet weak var _thirdButton: UIButton!
    @IBOutlet weak var _cancelButton: UIButton!
    @IBOutlet weak var _okButton: UIButton!
    @IBOutlet weak var _textField: UITextField!
    @IBOutlet weak var _countLabel: UILabel!
    
    var ratingType: String?
    var likeState: Bool? // if true like, if false dislike
    var selectedUserId: Int?

    weak var delegate: ModalViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        
        let def = UserDefaults.standard
        likeState = def.bool(forKey: userDefKeys.likeState.rawValue)
        
        configureButtons()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _textField.delegate = self
        
        _textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        _countLabel.text = "0/24"
    }
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }
    
    func addLikeOrDislike( ratingType: String, apiUrl: String ) {
        
        let def = UserDefaults.standard
        let token = def.string(forKey: userDefKeys.token.rawValue)
        
        print("func addLikeOrDislike ==================")
        print(token)
        print(apiUrl)
        print(ratingType)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        let body: [String : Any] = [
            "ratingType": "\(String(describing: ratingType))"
        ]
        
        Alamofire.request(apiUrl, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                print("Success")
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    func configureButtons() {
        
        if likeState! {
            _firstButton.setTitle("Best Looker", for: .normal)
            _firstButton.layer.cornerRadius = 5
            _secondButton.setTitle("Super Worker", for: .normal)
            _secondButton.layer.cornerRadius = 5
            _thirdButton.setTitle("Extrovert", for: .normal)
            _thirdButton.layer.cornerRadius = 5
        } else {
            _firstButton.setTitle("Untidy", for: .normal)
            _firstButton.layer.cornerRadius = 5
            _secondButton.setTitle("Deadliner", for: .normal)
            _secondButton.layer.cornerRadius = 5
            _thirdButton.setTitle("Introvert", for: .normal)
            _thirdButton.layer.cornerRadius = 5
        }
        
        _cancelButton.layer.cornerRadius = 5
        _okButton.layer.cornerRadius = 5
    }

    @IBAction func firstAction(_ sender: Any) {
        
        if likeState! {
            ratingType = "like_best_looker"
        } else {
            ratingType = "dislike_untidy"
        }
        _firstButton.backgroundColor = UIColor.blue
        _secondButton.backgroundColor = UIColor.darkGray
        _thirdButton.backgroundColor = UIColor.darkGray
    }
    
    @IBAction func secondAction(_ sender: Any) {
        
        if likeState! {
            ratingType = "like_super_worker"
        } else {
            ratingType = "dislike_deadliner"
        }
        _firstButton.backgroundColor = UIColor.darkGray
        _secondButton.backgroundColor = UIColor.blue
        _thirdButton.backgroundColor = UIColor.darkGray
    }
    
    @IBAction func thirdAction(_ sender: Any) {
        
        if likeState! {
            ratingType = "like_extrovert"
        } else {
            ratingType = "dislike_introvert"
        }
        _firstButton.backgroundColor = UIColor.darkGray
        _secondButton.backgroundColor = UIColor.darkGray
        _thirdButton.backgroundColor = UIColor.blue
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
        
        if let unwrappedRatingType = ratingType {
            ratingType = unwrappedRatingType
            
            var API_URL = ""
            
            let def = UserDefaults.standard
            selectedUserId = def.integer(forKey: userDefKeys.selectedUserId.rawValue)
            
            if likeState! {
                
                API_URL = "\(dURL.dynamicURL.rawValue)profiles/\(String(describing: selectedUserId!))/like"
            } else {
                API_URL = "\(dURL.dynamicURL.rawValue)profiles/\(String(describing: selectedUserId!))/dislike"
            }
            
            addLikeOrDislike(ratingType: ratingType!, apiUrl: API_URL)
            dismiss(animated: true, completion: nil)
            delegate?.removeBlurredBackgroundView()
            
        } else {
            return
        }
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
    
    // Notifications for moving view when keyboard appears.
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Removing notifications.
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if _textField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
}

extension ModalViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if range.length + range.location > _textField.text!.count {
            return false
        }
        let newLenghth = _textField.text!.count + string.count - range.length
        return newLenghth < 25
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        _countLabel.text = "\(_textField.text!.count)/24"
    }
}
