//
//  CorrectViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 21/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit

class CorrectViewController: UIViewController {

    var delegate:GameDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextNumber() {
        self.delegate.round = self.delegate.round + 1
        if (self.delegate.round <= self.delegate.totalRound) {
            self.delegate.nextGame()
        }
        
        self.dismissViewControllerAnimated(true, completion: {
            if (self.delegate.round > self.delegate.totalRound) {
                self.delegate.gameOver()
            }
        })
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
