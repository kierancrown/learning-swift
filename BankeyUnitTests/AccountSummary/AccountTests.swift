//
//  AccountTests.swift
//  BankeyUnitTests
//
//  Created by Kieran Crown on 23/07/2023.
//

import Foundation
import XCTest

@testable import Bankey

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let results = try decoder.decode([Account].self, from: data)
        
        XCTAssertEqual(results.count, 2)
        
        let firstResult = results[0]
        let secondResult = results[1]
        
        XCTAssertEqual(firstResult.id, "1")
        XCTAssertEqual(firstResult.type, AccountType.Banking)
        XCTAssertEqual(firstResult.name, "Basic Savings")
        XCTAssertEqual(firstResult.amount, 929466.23)
        XCTAssertEqual(firstResult.createdDateTime.monthDayYearString, "Jun 21, 2010")
        
        XCTAssertEqual(secondResult.id, "2")
        XCTAssertEqual(secondResult.type, AccountType.Banking)
        XCTAssertEqual(secondResult.name, "No-Fee All-In Chequing")
        XCTAssertEqual(secondResult.amount, 17562.44)
        XCTAssertEqual(secondResult.createdDateTime.monthDayYearString, "Jun 21, 2011")
        
    }
}
