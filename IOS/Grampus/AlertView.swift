//
//  AlertView.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/30/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    
    func showAlert(view: UIViewController , title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
}
