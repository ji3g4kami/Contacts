//
//  RContact.swift
//  Contacts
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation
import RealmSwift

class RContact: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var address: String = ""
    @objc dynamic var phoneNumber: String = "N/A"
    @objc dynamic var email: String = ""
    @objc dynamic var marketing: Bool = true
    @objc dynamic var createdAt: Int = -1
    @objc dynamic var updatedAt: Int = -1
    
    
    init(contact: Contact) {
        self.id = contact.id
        self.title = contact.title
        self.firstName = contact.firstName
        self.lastName = contact.lastName
        self.address = contact.address
        self.phoneNumber = contact.phoneNumber ?? "N/A"
        self.email = contact.email
        self.marketing = contact.marketing
        self.createdAt = contact.createdAt
        self.updatedAt = contact.updatedAt ?? -1
    }
    
    required init() {
        super.init()
    }
}
