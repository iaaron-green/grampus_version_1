//
//  ViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/20/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import JWTDecode
import Alamofire
import ValidationComponents

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    @IBOutlet weak var _signInButton: UIButton!
    @IBOutlet weak var _signUpButton: UIButton!
    
    let predicate = EmailValidationPredicate()
    let alert = AlertView()
    let API_URL: String = "\(dURL.dynamicURL.rawValue)users/login"

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _userName.delegate = self
        _password.delegate = self
        
        SetUpOutlets()
        dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }
    
    // Save authorize state.
    func saveLoggedState() {
        let def = UserDefaults.standard
        def.set(true, forKey: userDefKeys.isLoggedIn.rawValue)
        def.synchronize()
    }
    
    func saveUserToken( token: String ) {
        let def = UserDefaults.standard
        def.set("\(token)", forKey: userDefKeys.token.rawValue)
        def.synchronize()
    }
    
    func saveUserId( userId: String ) {
        let def = UserDefaults.standard
        def.set("\(userId)", forKey: userDefKeys.userId.rawValue)
        def.synchronize()
    }
    
    func decodeJwt( token: String) {
        
        let jwt = try! decode(jwt: token)
        print("Decoded jwt ----------------\(jwt)")
        let userId = jwt.claim(name: "id").rawValue
        print("USER ID: \(userId!)")
        saveUserId(userId: userId! as! String)
        
    }
    
    func signIn() {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String : Any] = [
            "username": String(describing: _userName.text!),
            "password": String(describing: _password.text!),
        ]
        
        Alamofire.request(API_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                
                if let result = responseJSON.result.value {
                    let JSON = result as! NSDictionary
                    
                    let tokenWithBearer = (JSON["token"]! as! String)
                    let wordToRemove = "Bearer "
                    let tokenWithOutBearer = tokenWithBearer.deletingPrefix(wordToRemove)
                    
                    self.saveUserToken(token: tokenWithOutBearer)
                    print(tokenWithOutBearer)
                    
                    self.decodeJwt(token: tokenWithOutBearer)
                    self.saveLoggedState()
                    self.performSegue(withIdentifier: segueIdentifier.login_to_profile.rawValue, sender: self)
                }
                
            case .failure(let error) :
                self.showAlert("Incorrect input", "User not found!")
                print(error)
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func SignInButton(_ sender: UIButton) {
       
        let email = _userName.text
        let emailFormatBool = predicate.evaluate(with: email)
        
        // Email isEmpty check.
        if (email!.isEmpty) {
            showAlert("Incorrect input", "Enter Email!")
            
            return
        } else {
            // Email validation.
            if (!emailFormatBool) {
                showAlert("Incorrect input", "Email format not correct!")
                
                return
            }
        }
        
        // Check lenght of password
        if let password = _password.text {
            if password.count < 6 {
                showAlert("Password too short", "Password shoud be more than 5 characters!")
                
            } else if password.count >= 24 {
                showAlert("Password too long", "Password shoud be less then 24 symbols")
                
            }
        }
        
        signIn()
    }
    
    func showAlert(_ title: String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func SetUpOutlets() {
        
        _userName.layer.shadowColor = UIColor.darkGray.cgColor
        _userName.layer.shadowOffset = CGSize(width: 3, height: 3)
        _userName.layer.shadowRadius = 5
        _userName.layer.shadowOpacity = 0.5
        
        _password.layer.shadowColor = UIColor.darkGray.cgColor
        _password.layer.shadowOffset = CGSize(width: 3, height: 3)
        _password.layer.shadowRadius = 5
        _password.layer.shadowOpacity = 0.5
        
        _signInButton.layer.shadowColor = UIColor.darkGray.cgColor
        _signInButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        _signInButton.layer.shadowRadius = 5
        _signInButton.layer.shadowOpacity = 0.5
        
        _signUpButton.layer.shadowColor = UIColor.darkGray.cgColor
        _signUpButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        _signUpButton.layer.shadowRadius = 5
        _signUpButton.layer.shadowOpacity = 0.5
        
        _signInButton.layer.cornerRadius = 5
        _signUpButton.layer.cornerRadius = 5
        
    }
    
    // Hide keyboard on tap.
    func dismissKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Hide Keyboard.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Hide the keyboard when the return key pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            if _userName.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            } else if _password.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
    
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
