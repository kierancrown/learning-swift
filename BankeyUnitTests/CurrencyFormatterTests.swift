//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Kieran Crown on 14/07/2023.
//
import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakPoundsIntoPence() throws {
        let result = formatter.breakIntoPoundsAndPence(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testPoundsFormatted() throws {
        let result = formatter.poundsFormatted(17000)
        XCTAssertEqual(result, "£17,000.00")
    }
    
    func testZeroPoundsFormatted() throws {
        let result = formatter.poundsFormatted(0)
        XCTAssertEqual(result, "£0.00")
    }
}
