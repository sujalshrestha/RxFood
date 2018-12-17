//
//  ContactsController.swift
//  RxFood
//
//  Created by Hira on 12/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Contacts

class ContactsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchContacts()
    }

    fileprivate func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to fetch contacts ", err)
                return
            }

            if granted {
               print("granted")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                    })
                } catch let err {
                    print("err: ", err)
                }


            } else {
                print("denied")
            }
        }
    }
}
