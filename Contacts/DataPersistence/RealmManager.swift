//
//  RealmManager.swift
//  Contacts
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    
    let realm: Realm = try! Realm()
    
    func createContact(_ contact: Contact) throws {
        do {
            try realm.write() {
                realm.add(RContact(contact: contact))
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func createContacts(_ contacts: [Contact]) {
        contacts.forEach {
            try? createContact($0)
        }
    }
    
    func readContacts() -> Results<RContact> {
        return try! realm.objects(RContact.self).sorted(byKeyPath: "firstName", ascending: true)
    }
    
    func updateContacts(_ contacts: [Contact]) {
        deleteAllContacts()
        createContacts(contacts)
    }
    
    func deleteAllContacts() {
        let contacts = readContacts()
        try! realm.write() {
            realm.delete(contacts)
        }
    }
}
