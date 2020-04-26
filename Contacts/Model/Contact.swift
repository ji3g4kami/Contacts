//
//  Contact.swift
//  Contacts
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation

struct Contact: Codable {
    let id: Int
    let title, firstName, lastName, address: String
    let phoneNumber: String?
    let email: String
    let marketing: Bool
    let createdAt: Int
    let updatedAt: Int?
}
