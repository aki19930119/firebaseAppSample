//
//  User.swift
//  firebaseApp
//
//  Created by 柿沼儀揚 on 2020/07/10.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import Foundation
import FirebaseFirestore

class User {
    
    let email: String
    let password: String
    let createdAt: Timestamp
    
    var uid: String?
    
    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.password = dic["password"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
