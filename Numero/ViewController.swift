//
//  ViewController.swift
//  Numero
//
//  Created by Ho Yin Cheung on 11/21/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit
import AddressBook

class ViewController: UIViewController {

    var addressBook:ABAddressBookRef!
    var peopleDB:[String:String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let status = ABAddressBookGetAuthorizationStatus()
        if status == .Denied || status == .Restricted {
            // user previously denied, to tell them to fix that in settings
            return
        }
        
        // open it
        var error: Unmanaged<CFError>?
        self.addressBook = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue()
        if self.addressBook == nil {
            println(error?.takeRetainedValue())
            return
        }
        
        
        requestAddressBookAccess()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestAddressBookAccess() {
        
        ABAddressBookRequestAccessWithCompletion(self.addressBook) {
            granted, error in
            
            if !granted {
                // warn the user that because they just denied permission, this functionality won't work
                // also let them know that they have to fix this in settings
                return
            }

            let people:[ABRecordRef] = ABAddressBookCopyArrayOfAllPeople(self.addressBook)?.takeRetainedValue() as [ABRecordRef]
            
            self.createPersonDB(people)
         
        }
    }
    
    // Query everyone first number and store in a collection
    func createPersonDB(people:[ABRecordRef]) {
        let count = people.count
        for (var idx=0; idx < count; idx++) {
            let candidate:ABRecordRef = people[idx]
            let candidateName = ABRecordCopyCompositeName(candidate).takeUnretainedValue()
            let phoneRecords:ABMultiValueRef = ABRecordCopyValue(candidate, kABPersonPhoneProperty).takeUnretainedValue()
            // No phone number
            if (ABMultiValueGetCount(phoneRecords) == 0) {
                continue
            }
            
            // There is phone number
            let phoneNumber:String = ABMultiValueCopyValueAtIndex(phoneRecords, 0).takeUnretainedValue() as String
            
            self.peopleDB[candidateName] = phoneNumber
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "gameStart") {
            var vc:GameViewController = segue.destinationViewController as GameViewController
            vc.peopleDB = peopleDB
        }
    }
    
}

