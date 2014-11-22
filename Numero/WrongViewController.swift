//
//  WrongViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 21/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit

class WrongViewController: UIViewController {

    @IBOutlet var number:UILabel!
    @IBOutlet var name:UILabel!
    var correctAnswerName:String!
    var correctAnswerPhone:String!
    var delegate:nextGameDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.number.text = correctAnswerPhone
        self.name.text = correctAnswerName

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextNumber() {
       // let vc = self.parentViewController.parentViewController as GameViewController
        self.delegate.nextGame()
        self.dismissViewControllerAnimated(true, completion: {
            
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

protocol nextGameDelegate {
    func nextGame()
}
