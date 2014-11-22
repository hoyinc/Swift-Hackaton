//
//  GameOverViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 22/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    var score:Int!
    @IBOutlet var scoreLabel:UILabel!
    
    var delegate:GameOverDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreLabel.text = NSString(format: "%d/10", score)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newGame() {
        self.delegate.restartGame()
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    func updateScore(score:Int) {
        self.score = score
    }
    
}

protocol GameOverDelegate {
    func restartGame()
}
