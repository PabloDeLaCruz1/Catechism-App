//
//  Person.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/12/22.
//

import Foundation

class Person
{
    
    var name: String = ""
    var age: Int = 0
    var id: Int = 0
    
    init(id:Int, name:String, age:Int)
    {
        self.id = id
        self.name = name
        self.age = age
    }
    
}
