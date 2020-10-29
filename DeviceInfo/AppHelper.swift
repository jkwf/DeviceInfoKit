//
//  AppHelper.swift
//  DeviceInfo
//
//  Created by KangFang on 2020/6/28.
//  Copyright © 2020 KangFang. All rights reserved.
//

import UIKit

class AppHelper: NSObject {
    
    /// 获取设备型号
    /// - Returns: <#description#>
    class func getDevicePlatform() -> String {
        if let bundlePath = Bundle.main.path(forResource: "DeviceInfo", ofType: "plist"), let dicData = NSDictionary(contentsOfFile: bundlePath) {
            var systemInfo = utsname()
            uname(&systemInfo)
            let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
                return String(cString: ptr)
            }
            guard let plat = dicData[platform] as? String else {
                return "Unknown"
            }
            return plat
        }
        return "Unknown"
    }
    
    /// 获取当前是星期几
    /// - Parameter dateStr: 时间字符串
    /// - Returns: <#description#>
    class func getWeekforDate(dateStr: String) -> String {
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let date = dateFmt.date(from: dateStr)
        //        let calendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)
        //        //        let zone = TimeZone.init(secondsFromGMT: <#T##Int#>)
        //        let timeZone = TimeZone(identifier: "Asia/Shanghai")
        ////        let timezone = NSTimeZone.init(name: "Asia/Shanghai")
        //        calendar?.timeZone = timeZone!
        //        let comp = calendar?.components(NSCalendar.Unit.weekday, from: date!)
        //        let weakStr = array[(comp?.weekday)!]
        //        print("============================\(weakStr)")
        let interval = Int((date?.timeIntervalSince1970)!) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval / 86400) // 24*60*60
        let weekday = ((days + 4) % 7 + 7) % 7
      
        let weekArr = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]

        return weekArr[weekday]
    }
    
    /// 清空UserDefaults里的用户数据
    class func resetUserDefaults() {
        guard let domain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
    
    /// 判断版本对比
    /// - Parameter oldVersion: <#oldVersion description#>
    class func compareVersion(oldVersion: String) {
        guard let info = Bundle.main.infoDictionary, let version = info["CFBundleShortVersionString"] as? String, let buildVersion = info["CFBundleVersion"] as? String else {
            return
        }
        let old = oldVersion as NSString
        let result = old.compare(version, options: .numeric)
        if result == .orderedAscending {
            // old < current
        } else if result == .orderedDescending {
            // old > current
        } else {
            // old = current
        }
        
    }
}
