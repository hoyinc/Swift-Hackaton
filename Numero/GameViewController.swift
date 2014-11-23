//
//  GameViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 21/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit
import AddressBook

class GameViewController: UIViewController, StopWatchDelegate, GameDelegate {
    
    var peopleDB:[String:String]!
    @IBOutlet var phoneNumberLabel:UILabel!
    @IBOutlet var nameChoiceButtons:[UIButton]!
    @IBOutlet var timerLabel:UILabel!
    @IBOutlet var roundLabel:UILabel!
    var stopWatchTimer:StopWatch!
    var round:Int!
    var myTimer:NSTimer!
    var answer:String!
    var score:Int!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        stopWatchTimer = StopWatch()
        stopWatchTimer.delegate = self
        if (peopleDB.count < 10) { // to make the game more fun append some delivery phone number
            peopleDB["Pizza Hut Delivery"] = "3180-0000"
            peopleDB["McDonald Delivery"] = "2338-2338"
            peopleDB["KFC Delivery"] = "2180-0000"
            peopleDB["Cathy Pacific"] = "2747-3333"
            peopleDB["SmarTone Hotline"] = "2880-2688"
            peopleDB["Directory Service"] = "1081"
        }
        
        // game Start
        gameStart()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameStart() {
        round = 1
        score = 0
        
        createNewRound()
        stopWatchTimer.start(5)
        myTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
        
    }
    
    func createNewRound() {
        roundLabel.text = NSString(format: "%d/10", round)
        
        let candidates = self.pickCandidates()
        
        let pickidx = arc4random() % 3
        
        // Store target name to answer
        self.answer = candidates[Int(pickidx)]
        let gamePhoneNumber = self.peopleDB[self.answer]
        
        phoneNumberLabel.text = gamePhoneNumber

    }
    
    func nextGame() {
        round = round + 1
        createNewRound()
        stopWatchTimer.start(5)
        myTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
    }
    
    func pickCandidates() -> [String]{
        let peopleInDB = [String](self.peopleDB.keys)
        var candidates:[String] = []
        var pickedIndex:[Int] = []
        let count = self.peopleDB.count
        // pick 3 keys for
        for (var i=0; i < 3; i) {
            let idx = Int(arc4random() % UInt32(count))
            if (find(pickedIndex, idx) == nil) {
                
                pickedIndex.insert(idx, atIndex:i)
                candidates.insert(peopleInDB[idx], atIndex: i)
                self.nameChoiceButtons[i].setTitle(candidates[i], forState: UIControlState.Normal)
                i++
            }
          
        }
        //println(candidate
        return candidates
    }
    
    func refreshUI() {
        timerLabel.text = String(format: "%02d", stopWatchTimer.durationInSec)
    }
    
    func updateTimer() {
        stopWatchTimer.update()
        refreshUI()
    }
    
    func stop() {
        myTimer!.invalidate()
        // time up then lost
        let WrongVC:WrongViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("wrongVC") as WrongViewController
        WrongVC.delegate = self
        self.presentViewController(WrongVC, animated: true, completion: nil)
        
    }
    
    @IBAction func pickName(sender:AnyObject) {
        myTimer!.invalidate()
        var answer:String! = (sender as UIButton).titleLabel?.text
        if (answer == self.answer) {
            score = score + 1
            let CorrectVC:CorrectViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("correctVC") as CorrectViewController
            CorrectVC.roundNumber = self.roundLabel.text
            CorrectVC.delegate = self
            self.presentViewController(CorrectVC, animated: true, completion: nil)
        }
        else {
            let WrongVC:WrongViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("wrongVC") as WrongViewController
            WrongVC.correctAnswerPhone = self.peopleDB[self.answer]
            WrongVC.correctAnswerName = self.answer
            WrongVC.roundNumber = self.roundLabel.text
            WrongVC.delegate = self
            self.presentViewController(WrongVC, animated: true, completion: nil)
        }
    }
    
    func gameOver() {
        let gameOverVC:GameOverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("gameover") as GameOverViewController
        gameOverVC.updateScore(score)
        gameOverVC.delegate = self
        self.presentViewController(gameOverVC, animated: true, completion: nil)
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

// a protocol for managing the game
protocol GameDelegate {
    var round:Int! {get set}
    var score:Int! {get set}
    
    func gameStart()
    func nextGame()
    func gameOver()
}


