//
//  Clock.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/17.
//

import Foundation

struct Clock {
    var uuid: String
    var clockTag: String
    var clockHour: String
    var clockMinute: String
    var clockRingString: String
    var clockRepeatString: String
    
    var clockTime: Bool
    var clockRimind: Bool
    
    var clockRingBool: [Bool]
    var clockRepeatBool: [Bool]
}
