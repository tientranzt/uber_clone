//
//  User.swift
//  hello_world
//
//  Created by tientran on 26/12/2020.
//

import Foundation

struct User {
    
    let fullName : Any
    let pass : Any
    let email : Any
    
    init(user  : [String: Any]) {
        self.fullName = user["fullName"] ?? ""
        self.pass = user["pass"] ?? ""
        self.email = user["email"] ?? ""
    }
    
}
