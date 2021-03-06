//
//  RealmContact.swift
//  ContactManager
//
//  Created by Oleksandr Revebtsov on 2022-06-06.
//

import Foundation
import RealmSwift

class RealmContact: Object {
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?

        override init() {
            super.init()
        }
        
        init(with contact: Contact) {
            super.init()
            self.firstName = contact.firstName
            self.lastName = contact.lastName

        }
        
        @available(*, unavailable)
        required init(from decoder: Decoder) throws {
            let msg = "init(from:) has not been implemented"
            fatalError(msg)
        }
}
