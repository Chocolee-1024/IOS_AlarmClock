//
//  ClockPreferences.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/13.
//

import Foundation

class ClockPreferences: NSObject {
    
    static let shared = ClockPreferences()
    
    enum Keys: String {
        case clockTag
        
        case clockRepeatBool
        
        case clockRepeatString
        
        case clockRingBool
        
        case clockRingString
        
        case clockRimind
        
        case clockMinute
        
        case clockHour
        
        case clockTime
        
        case uuid
        
        
    }
    
    var clockTag: String {
        get{return UserDefaults.standard.string(forKey: Keys.clockTag.rawValue) ?? "鬧鐘"}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockTag.rawValue)}
    }
    
    var clockRepeatBool: [Bool] {
        get{return UserDefaults.standard.array(forKey: Keys.clockRepeatBool.rawValue) as? [Bool] ?? []}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockRepeatBool.rawValue)}
    }
    var clockRepeatString: String {
        get{return UserDefaults.standard.string(forKey: Keys.clockRepeatString.rawValue) ?? "永不"}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockRepeatString.rawValue)}
    }
    var clockRingBool: [Bool] {
        get{return UserDefaults.standard.array(forKey: Keys.clockRingBool.rawValue) as? [Bool] ?? []}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockRingBool.rawValue)}
    }
    var clockRingString: String {
        get{return UserDefaults.standard.string(forKey: Keys.clockRingString.rawValue) ?? "我的歌曲"}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockRingString.rawValue)}
    }
    
    var clockRimind: Bool {
        get{return UserDefaults.standard.bool(forKey: Keys.clockRimind.rawValue)}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockRimind.rawValue)}
    }
    
    var clockMinute: String {
        get{return UserDefaults.standard.string(forKey: Keys.clockMinute.rawValue) ?? "00"}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockMinute.rawValue)}
    }
    
    var clockHour: String {
        get{return UserDefaults.standard.string(forKey: Keys.clockHour.rawValue) ?? "1"}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockHour.rawValue)}
    }
    
    var uuid: String {
        get{return UserDefaults.standard.string(forKey: Keys.uuid.rawValue) ?? ""}
        set{UserDefaults.standard.set(newValue, forKey: Keys.uuid.rawValue)}
    }
    
    var clockTime: Bool {
        get{return UserDefaults.standard.bool(forKey: Keys.clockTime.rawValue)}
        set{UserDefaults.standard.set(newValue, forKey: Keys.clockTime.rawValue)}
    }
    
    
}
