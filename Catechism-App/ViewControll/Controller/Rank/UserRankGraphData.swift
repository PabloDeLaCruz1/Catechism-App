//
//  UserRank.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/18/22.
//

import Foundation
struct UserRankGraphData {
    var order: Int
    var score: String
    var technology: String
    var percentage: Double
    
    init (order: Int, score: String, technology: String, percentage: Double) {
        self.order = order
        self.score = score
        self.technology = technology
        self.percentage = percentage
    }
}
