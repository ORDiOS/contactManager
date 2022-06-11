//
//  DataBaseNanager.swift
//  ContactManager
//
//  Created by Oleksandr Revebtsov on 2022-06-06.
//

import Foundation
import RealmSwift

class DataBaseManager {
    let queue = DispatchQueue(label: "realmQueue")
    static let shared = DataBaseManager()
    
    private init() {
        // use for Singleton
    }
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            let message = "error in opening DB: \(error)."
            print(message)
            let error = error as NSError
            if error.code == 10 || error.code == 2 || error.code == 1, let fileUrl = Realm.Configuration.defaultConfiguration.fileURL {
                try? FileManager.default.removeItem(at: fileUrl)
            }
            let innerRealm = try? Realm()
            if innerRealm == nil {
                assertionFailure()
                let msg = "We failed to create Realm instance because of \(error.localizedDescription)"
                print(msg)
            }
            return innerRealm
        }
    }
    
    func save(contacts: [Contact]) {
            var realmContacts = [RealmContact]()
            contacts.forEach { realmContacts.append(RealmContact(with: $0)) }
            do {
                try realm?.write {
                    realm?.add(realmContacts)
                }
            } catch {
                assertionFailure()
                let msg = error.localizedDescription
                print(msg)
            }
    }
    
    func getContacts() -> Results<RealmContact> {
        return (self.realm?.objects(RealmContact.self))!
    }
    
    func dataBaseIsEmpty() -> Bool{
        return DataBaseManager.shared.getContacts().isEmpty ? true: false
        }
        
}
