//
//  ValidateApp.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/18/22.
//

import Foundation
class ValidateApp{
    
    func validation(id: String, pass : String) -> Bool {
        if (id != "") && (pass != ""){
            print("************************   true      ********************")
            return true
        }else{
            print("************************   false      ********************")
            return false
        }
        
    }
}
