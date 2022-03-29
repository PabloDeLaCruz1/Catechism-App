//
//  RunningTimeRepository.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/18/22.
//

import Foundation

class RunningTimeRepository {
    
    static let instance = RunningTimeRepository()
    
    var timeGraphCollection: [UserRankGraphData]?
    
    func retrieveTimeGraphCollection (completion: @escaping ([UserRankGraphData]?) -> ()) {
        
        if timeGraphCollection != nil {
            completion(timeGraphCollection)
        } else {
            timeGraphCollection = self.createTimeCollection()
            completion(timeGraphCollection)
        }
    }
    
    private func createTimeCollection () -> [UserRankGraphData] {
        
        let second = UserRankGraphData.init(order: 0, score: "80", technology: "PABLO", percentage: 50)
        let first = UserRankGraphData.init(order: 1, score: "100", technology: "YOUNG", percentage: 80.0)
        let third = UserRankGraphData.init(order: 2, score: "70", technology: "DAVID", percentage: 25.6)

        
        return [second,first,third]
    }
    
}
