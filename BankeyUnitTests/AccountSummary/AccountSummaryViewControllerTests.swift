//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by Kieran Crown on 23/07/2023.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockProfileManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
        
        mockProfileManager = MockProfileManager()
        vc.profileManager = mockProfileManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual(titleAndMessage.0, "Server Error")
        XCTAssertEqual(titleAndMessage.1, "We could not process your request. Please try again.")
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual(titleAndMessage.0, "Network Error")
        XCTAssertEqual(titleAndMessage.1, "Ensure you are connected to the internet. Please try again.")
    }
    
    func testAlertForServerError() throws {
        mockProfileManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual(vc.errorAlert.title, "Server Error")
        XCTAssertEqual(vc.errorAlert.message, "We could not process your request. Please try again.")
    }
    
    func testAlertForDecodeError() throws {
        mockProfileManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual(vc.errorAlert.title, "Network Error")
        XCTAssertEqual(vc.errorAlert.message, "Ensure you are connected to the internet. Please try again.")
    }
}
