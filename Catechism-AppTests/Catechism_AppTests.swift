//
//  Catechism_AppTests.swift
//  Catechism-AppTests
//
//  Created by David Gonzalez on 3/18/22.
//

import XCTest
@testable import Catechism_App // name project

class Catechism_AppTests: XCTestCase {
    
    let valid  = ValidateApp()
    func testValidation_return_true_TFNotEmpty(){
        
        XCTAssertTrue(valid.validation(id: "lizy", pass: "123"))
        
    }
    
    func testValidation_return_false_TFNotEmpty(){
        
        XCTAssertFalse(valid.validation(id: "", pass: ""))
        
    }
    
    
    func testURLOpenigTask(){
        var d : Data?
        let expect = expectation(description: "should open url within five time")
        let url = URL(string: "https://apple.com")
     
        URLSession.shared.dataTask(with: url!){
            data , _ , _ in
            d = data
            print("got the data", d)
            XCTAssertNotNil(data)
            expect.fulfill()
        }.resume()
        wait(for: [expect], timeout: 8)
            
        }



}
