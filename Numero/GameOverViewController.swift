//
//  GameOverViewController.swift
//  Numero
//
//  Created by Sunny Cheung on 22/11/14.
//  Copyright (c) 2014 Ho Yin Cheung. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet var scoreLabel:UILabel!
    
    var delegate:GameDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreLabel.text = NSString(format: "%d/10", self.delegate.score)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newGame() {
        self.delegate.gameStart()
        self.dismissViewControllerAnimated(true , completion: {
          
        })
    }
    
}
/*
protocol GameOverDelegate {
    func restartGame()
}
*/