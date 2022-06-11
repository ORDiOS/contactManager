//
//  Contact.swift
//  ContactManager
//
//  Created by Oleksandr Revebtsov on 2022-06-06.
//

import Foundation

struct ListofContacts: Codable {
    let contacts: [Contact]
}

struct Contact: Codable {
    private enum CodingKeys: String, CodingKey {
        case firstName, lastName
    }
    let firstName: String?
    let lastName: String?
   
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String?.self, forKey: .firstName)
        lastName = try container.decode(String?.self, forKey: .lastName)
    }
    
    init(firstName: String?, lastName: String?) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
