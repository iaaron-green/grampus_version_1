//
//  Enums.swift
//  Grampus
//
//  Created by Тимур Кошевой on 6/7/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import Foundation

enum segueIdentifier: String {
    case login_to_profile = "login_to_profile"
    case rating_to_selected_profile = "rating_to_selected_profile"
}

enum dURL: String {
    case dynamicURL = "http://10.11.1.79:8080/api/"
}

enum userDefKeys: String {
    case isLoggedIn = "isLoggedIn"
    case token = "token"
    case userId = "userId"
    case likeState = "like"
    case selectedUserId = "selectedUserId"
    case profileState = "profileState"  // if true show logged user profile, if false show selected user profile
    case selectedUserIdProfile = "selectedUserIdProfile"
}
