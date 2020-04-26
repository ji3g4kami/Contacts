//
//  ContactsTests.swift
//  ContactsTests
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactsTests: XCTestCase {

    var sut: [Contact]!
    
    override func setUpWithError() throws {
      super.setUp()
      let data = try getData(fromJSON: "Contacts")
      sut = try JSONDecoder().decode([Contact].self, from: data)
    }
    
    override func tearDownWithError() throws {
      sut = nil
      super.tearDown()
    }
    
    func testFirstContactJSONMapping() {
        let firstContact = sut.first!
        XCTAssertEqual(firstContact.id, 100)
        XCTAssertEqual(firstContact.title, "Mr")
        XCTAssertEqual(firstContact.firstName, "Steve")
        XCTAssertEqual(firstContact.lastName, "Williams")
        XCTAssertEqual(firstContact.address, "31 Old Street,\nWoolwich,\nLondon,\nSE15 7KE")
        XCTAssertEqual(firstContact.phoneNumber, "07888888888")
        XCTAssertEqual(firstContact.email, "steve@email.com")
        XCTAssertTrue(firstContact.marketing)
        XCTAssertEqual(firstContact.createdAt, 1587554436)
        XCTAssertEqual(firstContact.updatedAt, 1587554536)
    }

}
