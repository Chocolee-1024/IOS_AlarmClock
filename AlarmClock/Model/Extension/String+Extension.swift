//
//  String+Extension.swift
//  AlarmClock
//
//  Created by imac-1763 on 2023/2/21.
//

import Foundation

extension String {
    //MARK:- 字符串转时间戳
       func timeStrChangeTotimeInterval(_ dateFormat:String? = "yyyy-MM-dd HH:mm") -> String {
           if self.isEmpty {
               return ""
           }
           let format = DateFormatter.init()
           format.dateStyle = .medium
           format.timeStyle = .short
           if dateFormat == nil {
               format.dateFormat = "yyyy-MM-dd HH:mm"
           }else{
               format.dateFormat = dateFormat
           }
           let date = format.date(from: self)
           return String(date!.timeIntervalSince1970)
       }
}
