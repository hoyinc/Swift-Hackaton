//
//  StopWatchModel.swift
//  fourminutes
//
//  Created by Sunny Cheung on 15/9/14.
//  Copyright (c) 2014 khl. All rights reserved.
//

import Foundation

class StopWatch {
    var durationInSec: UInt8
    var startDate:NSDate
    var timer: UInt8
    var delegate:StopWatchDelegate?
    
    init() {
        durationInSec = 0
        timer = 0
        startDate = NSDate()
        
    }
    
    func start(time:UInt8) {
        startDate = NSDate()
        durationInSec = time
        timer = time
    }
    
    func update() {
        var currentDate = NSDate()
        var timeInterval:NSTimeInterval = currentDate.timeIntervalSinceDate(startDate)
        durationInSec =  timer - UInt8(timeInterval)
        if durationInSec == 0 {
            delegate?.stop()
        }
    }
}

protocol StopWatchDelegate {
    func stop()
}
