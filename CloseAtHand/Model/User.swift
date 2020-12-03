//
//  User.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 03/12/2020.
//

import Foundation

struct User {
    let uid: String
    let fullname: String
    let email: String
    var profilePictureURL: String?
    
    var firstInitial: String { return String(fullname.prefix(1)) }
    
    init(uid: String, dictionary: [String : Any]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let profilePicture = dictionary["profilePictureURL"] as? String {
            self.profilePictureURL = profilePicture
        }
    }
}
