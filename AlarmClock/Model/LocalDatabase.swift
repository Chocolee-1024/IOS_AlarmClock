import Foundation
import RealmSwift
class LocalDatabase: NSObject{
    // 單立
    static let share = LocalDatabase()
    
    // 抓資料
    func fetchFromDatabase() -> [Clock] {
        var clockArray: [Clock] = []
        let realms = try! Realm()
        let results = realms.objects(clockTable.self)
        if results.count > 0 {
            for i in results{
                var ringBool: [Bool] = []
                var repeatBool: [Bool] = []
                for x in i.clockRingBool {
                    ringBool.append(x)
                }
                for x in i.clockRepeatBool {
                    repeatBool.append(x)
                }
                clockArray.append(Clock(uuid: i.uuid, clockTag: i.clockTag, clockHour: i.clockHour, clockMinute: i.clockMinute, clockRingString: i.clockRingString, clockRepeatString: i.clockRepeatString, clockTime: i.clockTime, clockRimind: i.clockRimind, clockRingBool: ringBool, clockRepeatBool: repeatBool))
            }
        }
        return clockArray
    }
    
    // 新增
    func addClock() {
        let realm = try! Realm()
        let ringBool = List<Bool>()
        let repeatBool = List<Bool>()
        let table = clockTable()
        table.clockHour = ClockPreferences.shared.clockHour
        table.clockMinute = ClockPreferences.shared.clockMinute
        table.clockTag = ClockPreferences.shared.clockTag
        table.clockRimind = ClockPreferences.shared.clockRimind
        table.clockRingString = ClockPreferences.shared.clockRingString
        table.clockRepeatString = ClockPreferences.shared.clockRepeatString
        table.clockTime = ClockPreferences.shared.clockTime
        for x in ClockPreferences.shared.clockRepeatBool {
            repeatBool.append(x)
        }
        for x in ClockPreferences.shared.clockRingBool {
            ringBool.append(x)
        }
        table.clockRingBool = ringBool
        table.clockRepeatBool = repeatBool
        
        do{
            try realm.write{
                realm.add(table)
                print("File URL : \(String(describing: realm.configuration.fileURL?.absoluteURL))")
            }
        } catch {
            print("Realm Add Failed : \(error.localizedDescription)")
        }
    }
    
    // 刪除
    func deleteClock(uuid: String) {
        let realm = try! Realm()
        if let deleteClock = realm.objects(clockTable.self).filter("uuid = '\(uuid)'").first{
            do{
                try realm.write{
                    realm.delete(deleteClock)
                    print("File URL : \(String(describing: realm.configuration.fileURL?.absoluteURL))")
                }
            } catch {
                print("Realm Delete Failed : \(error.localizedDescription)")
            }
        }
    }
    
    //更新留言
    func updataClock() {
        let realm = try! Realm()
        let ringBool = List<Bool>()
        let repeatBool = List<Bool>()
        if let updataClock = realm.objects(clockTable.self).filter("uuid = '\(ClockPreferences.shared.uuid)'").first{
                try! realm.write{
                    updataClock.clockMinute = ClockPreferences.shared.clockMinute
                    updataClock.clockHour = ClockPreferences.shared.clockHour
                    updataClock.clockTag = ClockPreferences.shared.clockTag
                    updataClock.clockRingString = ClockPreferences.shared.clockRingString
                    updataClock.clockRepeatString = ClockPreferences.shared.clockRepeatString
                    updataClock.clockRimind = ClockPreferences.shared.clockRimind
                    for x in ClockPreferences.shared.clockRepeatBool {
                        repeatBool.append(x)
                    }
                    for x in ClockPreferences.shared.clockRingBool {
                        ringBool.append(x)
                    }
                    updataClock.clockRingBool = ringBool
                    updataClock.clockRepeatBool = repeatBool
                    
                    print("File URL : \(String(describing: realm.configuration.fileURL?.absoluteURL))")
                }
        }
    }
   
    // 更新
    func updataOpenClock() {
        let realm = try! Realm()
        if let updataClock = realm.objects(clockTable.self).filter("uuid = '\(ClockPreferences.shared.uuid)'").first{
            try! realm.write{
                updataClock.clockTime = ClockPreferences.shared.clockTime
                print("File URL : \(String(describing: realm.configuration.fileURL?.absoluteURL))")
            }
        }
    }
}
    class clockTable: Object {
        @Persisted(primaryKey: true) var uuid: String = UUID().uuidString
        
        @Persisted var clockTag: String
        @Persisted var clockHour: String
        @Persisted var clockMinute: String
        @Persisted var clockRingString: String
        @Persisted var clockRepeatString: String
        
        @Persisted var clockTime: Bool
        @Persisted var clockRimind: Bool
        
        @Persisted var clockRingBool: List<Bool>
        @Persisted var clockRepeatBool: List<Bool>
    }


