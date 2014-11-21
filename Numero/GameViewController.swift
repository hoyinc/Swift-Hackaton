//
//  GameViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 21/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit
import AddressBook

class GameViewController: UIViewController {
    
    var addressBook:ABAddressBookRef!
    var people:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        // request permission to use it
        
           }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ABAddressBookRequestAccessWithCompletion(self.addressBook) {
            
            (granted:Bool, error:CFError!) in
            
            if !granted {
                // warn the user that because they just denied permission, this functionality won't work
                // also let them know that they have to fix this in settings
                return
            }
            
            if let people = ABAddressBookCopyArrayOfAllPeople(self.addressBook)?.takeRetainedValue() as? NSArray {
               
            }
            
            // NSLog("%@", self.people);
            
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
