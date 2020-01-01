//
//  VirtualClassTests.swift
//  VirtualClassTests
//
//  Created by Alperen Aysel on 1.01.2020.
//  Copyright © 2020 Alperen. All rights reserved.
//

import XCTest
@testable import VirtualClass

class VirtualClassTests: XCTestCase {

    func testCorrectStudentLogin() {
        let vr = ViewController()
        vr.pullUsers()
        let result = vr.doesExist(name: "Eren", password: "1234")
        
        XCTAssertTrue(result)
        
        XCTAssertTrue(currentUser.isStudent)

    }
    
    func testCorrectTeacherLogin() {
        let vr = ViewController()
        vr.pullUsers()
        let result = vr.doesExist(name: "Alp", password: "123")
        
        XCTAssertTrue(result)
        
        XCTAssertFalse(currentUser.isStudent)

    }
    
    func testIncorrectLogin() {
        let vr = ViewController()
        vr.pullUsers()
        let result = vr.doesExist(name: "Test", password: "123")
        
        XCTAssertFalse(result)

    }
    
    
    func testUserID() {
        let vr = ViewController()
        vr.pullUsers()
        let result = vr.doesExist(name: "Alp", password: "123")
        
        XCTAssertTrue(result)
        
        XCTAssertEqual(currentUser.id, 3)
        
    }

}
