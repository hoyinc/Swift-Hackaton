//
//  GameViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 21/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit
import AddressBook

class GameViewController: UIViewController, StopWatchDelegate {
    
    var peopleDB:[String:String]!
    @IBOutlet var phoneNumberLabel:UILabel!
    @IBOutlet var nameChoiceButtons:[UIButton]!
    @IBOutlet var timerLabel:UILabel!
    @IBOutlet var roundLabel:UILabel!
    var stopWatchTimer:StopWatch!
    var round:Int!
    var candidates:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        stopWatchTimer = StopWatch()
        stopWatchTimer.delegate = self
        gameStart()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameStart() {
        round = 1
        roundLabel.text = NSString(format: "%d/10", round)
        
        self.candidates = []
        self.pickCandidates()
        
        let pickidx = arc4random() % 3
        let gamePhoneNumber = self.peopleDB[candidates[Int(pickidx)]]
        phoneNumberLabel.text = gamePhoneNumber
        
    }
    
    func pickCandidates(){
        let peopleInDB = [String](self.peopleDB.keys)
       // var candidates:[String] = []
        var pickedIndex:[Int] = []
        let count = self.peopleDB.count
        // pick 3 keys for
        for (var i=0; i < 3; i) {
            let idx = Int(arc4random() % UInt32(count))
            if (find(pickedIndex, idx) == nil) {
                pickedIndex.insert(idx, atIndex:i)
                self.candidates.insert(peopleInDB[i], atIndex: i)
                self.nameChoiceButtons[i].setTitle(candidates[i], forState: UIControlState.Normal)
                i++
            }
          
        }
        //println(candidate
        //return candidates
    }
    
    func stop() {
        // time up then lost
        
    }
    
    @IBAction func pickName(sender:AnyObject) {
       // var answer:String! = (sender as UIButton).titleLabel?.text
        
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
