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
    var people:CFArray!

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

            self.people =    ABAddressBookCopyArrayOfAllPeople(self.addressBook)?.takeRetainedValue()
         
            println(self.people)
        }
    }
    
}

