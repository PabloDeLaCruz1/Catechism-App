//
//  Catechism_AppUITests.swift
//  Catechism-AppUITests
//
//  Created by David Gonzalez on 3/18/22.
//

// Change info file the strt Sotryboard

import XCTest

class Catechism_AppUITests: XCTestCase {
    var measureOp = XCTMeasureOptions()
    func testLoginUI_Inputs_LoginButton(){
        let app = XCUIApplication()
        app.launch()
        
        
        let idTextField = app.textFields["idLogin"]
        idTextField.tap()
        idTextField.typeText("luis")
        
        let passTextField  = app.textFields["pass1"] // UNCHECKED SECURITY ATTRIBUTE
        passTextField.tap()
        passTextField.typeText("123")
        
        app.staticTexts["LOG-IN"].tap() // CHANGE LABEL LOGIN BUTTON TO LOG-IN
        
        
    }
    
    func testLoginUI_Inputs_LoginButton_performance(){
        measureOp.iterationCount = 2
        measure ( options: measureOp, block: {
            
            testLoginUI_Inputs_LoginButton()
        })
    }
    
}
