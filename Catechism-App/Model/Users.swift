//
//  Users.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/16/22.
//

import Foundation


class Users {
    var id: Int
    var name: String
    var password: String
    var subscriptionType: Int  // 0: free, 1: paid, 2: admin, 3: blocked
    var scoresBySubject = [String: Int]()
    init(id: Int, name: String, password: String, subscriptionType: Int)
    {
        self.id = id
        self.name = name
        self.password = password
        self.subscriptionType = subscriptionType
        self.scoresBySubject = ["Math" : 0, "iOS": 0, "Science": 0]

    }
    
    init() {
        self.id = 0
        self.name = "name"
        self.password = "password"
        self.subscriptionType = 4
        
        self.scoresBySubject = ["Math" : 0, "iOS": 0, "Science": 0]
    }
}
