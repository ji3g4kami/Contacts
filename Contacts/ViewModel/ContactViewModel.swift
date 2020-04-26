//
//  ContactViewModel.swift
//  Contacts
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation

class ContactViewModel {

    var id: Int
    var title: String
    var firstName: String
    var lastName: String
    var fullName: String { "\(firstName) \(lastName)" }
    var fullNameWithTitle: String
    var address: String
    var phoneNumber: String
    var email: String
    var marketing: Bool
    var createdAt: Int
    var creationFormattedString: String
    // -1 means there is no updatedAt
    var updatedAt: Int
    var updatedFormattedString: String {
        if updatedAt == -1 { return "N/A" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(updatedAt)))
    }
    var imageURL: URL? {
        return UserDefaults.standard.url(forKey: String(id))
    }
    
    init(_ rContact: RContact) {
        self.id = rContact.id
        self.title = rContact.title
        self.firstName = rContact.firstName
        self.lastName = rContact.lastName
        self.fullNameWithTitle = "\(rContact.title). \(rContact.firstName) \(rContact.lastName)"
        self.address = rContact.address
        self.phoneNumber = rContact.phoneNumber
        self.email = rContact.email
        self.marketing = rContact.marketing
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        self.createdAt = rContact.createdAt
        self.creationFormattedString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(rContact.createdAt)))
        self.updatedAt = rContact.updatedAt
    }
    
    /* UI displays the data from Realm only, thus commenting it out.
    init(_ contact: Contact) {
        self.id = contact.id
        self.title = contact.title
        self.firstName = contact.firstName
        self.lastName = contact.lastName
        self.fullNameWithTitle = "\(contact.title). \(contact.firstName) \(contact.lastName)"
        self.address = contact.address
        self.phoneNumber = contact.phoneNumber ?? "N/A"
        self.email = contact.email
        self.marketing = contact.marketing
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        self.createdAt = contact.createdAt
        self.creationFormattedString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(contact.createdAt)))
        self.updatedAt = contact.updatedAt ?? -1
    }
    */
    
    func generateImageURL() {
        let eye = (1..<10).randomElement()!
        let nose = (1..<10).randomElement()!
        let mouth = (1..<10).randomElement()!
        UserDefaults.standard.set(URL(string: "https://api.adorable.io/avatars/face/eyes\(eye)/nose\(nose)/mouth\(mouth)/DEADBF/200"), forKey: String(id))
    }
}
