//
//  date.service.swift
//  MrArthur
//
//  Created by Troo on 30/08/22.
//

import Foundation

enum EWeekDay:String{
    case MONDAY = "Monday"
    case TUESDAY = "Tuesday"
    case WEDNESDAY = "Wednesday"
    case THURSDAY = "Thursday"
    case FRIDAY = "Friday"
    case SATURDAY = "Saturday"
    case SUNDAY = "Sunday"
}

struct IGetHourMinuteSecondFromNowResponse {
    var hour: Int
    var minute: Int
    var second: Int
}

class DateService {
    
    static let shared: DateService = DateService()
    
    func getYearFromDateString(dateString: String, dateFormat: String = "dd/MM/yyyy") -> String? {
        if let date = dateString.convertUTCStringToDate(dateFormat: dateFormat) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = date.dateIn_yyyy_Format()
            return dateFormatter.string(from: date)
        }else if let dateDifFormate = dateString.convertUTCStringToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ"){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateDifFormate.dateIn_yyyy_Format()
            return dateFormatter.string(from: dateDifFormate)
        }
        return nil
    }
    
    func getWeekDayFromDateString(dateString: String, dateFormat: String = "dd/MM/yyyy") -> String? {
        if let date = dateString.convertUTCStringToDate(dateFormat: dateFormat) {
            let df = DateFormatter()
            return df.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        }
        return nil
    }
    
    func getStringDateWithSuffixfromDateString(dateString: String, dateFormat: String = "dd/MM/yyyy") -> String {
        if let date = dateString.convertUTCStringToDate(dateFormat: dateFormat) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = date.dateFormatWithSuffix()
            return dateFormatter.string(from: date)
        }
        return "NA"
    }
    func getEEEE_dd_MMMMStringDateFromDateString(dateString: String, dateFormat: String = "dd/MM/yyyy") -> String {
        if let date = dateString.convertUTCStringToDate(dateFormat: dateFormat) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = date.dateIn_EEEE_dd_MMMM_Format()
//            dateFormatter.locale = Locale(identifier: "fr")
            return dateFormatter.string(from: date).capitalized
        }
        return "NA"
    }

    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
    
    static func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func hoursMinutesSecondToSeconds(dateComponent: DateComponents) -> Int {
        return ((dateComponent.hour ?? 0) * 3600) + ((dateComponent.minute ?? 0) * 60) + (dateComponent.second ?? 0)
    }
    
    static func minutesToHoursMinutes(minute: Int) -> (Int, Int) {
        return (minute / 60, minute % 60)
    }
    
    static func getHourMinuteSecondFromNow() -> IGetHourMinuteSecondFromNowResponse {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        dump(calendar.component(.calendar, from: date))
        return IGetHourMinuteSecondFromNowResponse(hour: hour, minute: minute, second: second)
    }
    
    static func getFormatedDateFromNow() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
    }
    
    func getDateMonthYearFromNow() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: date)
    }
    
}

extension String {
    
    func dateFormatter(dateFormat: String = "yyyy-MM-dd", style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = .current
        formatter.dateStyle = style
        formatter.locale = Locale.current
        return formatter.string(from: Date())
    }
    
    func convertUTCStringToDate(dateFormat: String) -> Date? {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = formatter.date(from: self);
        return date;
    }
}


extension Date {
    
    func dateIn_EEEE_dd_MMMM_Format() -> String {
        return "EEEE dd MMMM"
    }
    
    func dateIn_yyyy_Format() -> String {
        return "yyyy"
    }
    
    func dateFormatWithSuffix() -> String {
        return "dd'\(self.daySuffix())' MMMM"
    }
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let countryCode = Date.getCountryCode()
        var rdFrench : String = "rd"
        var thFrench : String = "rd"
        if countryCode == "fr"{
            rdFrench = ""
            thFrench = ""
        } else {
            rdFrench = "rd"
            thFrench = "th"
        }
        
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return rdFrench
        default:
            return thFrench
        }
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    static func getCountryCode() -> String{
        let localRegion = Locale.current
        let countryCode = localRegion.regionCode!
        return countryCode
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func getDateFromTimeStamp(timeStamp : Double , DateFormate:String) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = DateFormate
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    //For timeStamp
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    //Convert UTC String To Date
    static func convertUTCStringToDate(_ strDate:String, dateFormat:String) -> Date?
    {
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = dateFormat;
        
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = formatter.date(from: strDate);
        return date;
    }
    
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addMinutes(_ minutsToAdd: Int) -> Date {
        let secondsInMinutes: TimeInterval = Double(minutsToAdd) * 60
        let dateWithMinutsAdded: Date = self.addingTimeInterval(secondsInMinutes)
        
        //Return Result
        return dateWithMinutsAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
}
