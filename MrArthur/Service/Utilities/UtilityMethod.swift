//
//  UtilityMethod.swift
//  MrArthur
//
//  Created by IPS-169 on 12/07/22.
//

import Foundation
import SwiftUI

struct UtilityMethod {
    private let imageCache = ImageCache.getImageCache()
    
    static func getQRCodeDate(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()
    }
    
    static let achivementCss = """
        @font-face {
            font-family: 'Montserrat-Regular';
            src: url("Montserrat-Regular.ttf") format('truetype');
        }
        @font-face {
            font-family: 'Montserrat-Bold';
            src: url("Montserrat-Bold.ttf") format('truetype');
        }
        .primaryRedBg {
            color: #FFFFFF;
            font-family: "Montserrat-Bold";
            font-size: \(15.sp);
            border-radius: \(24.r)px;
            padding: \(0.5.h) \(8.w);
            background-color: #FD657C;
            
        }
        .primaryYellowBg {
            color: #FFFFFF;
            font-family: "Montserrat-Bold";
            font-size: \(15.sp);
            border-radius: \(24.r)px;
            padding: \(0.5.h) \(8.w);
            background-color: #FFCE00;
        }

        .primaryBlueBg {
            color: #FFFFFF;
            font-family: "Montserrat-Bold";
            font-size: \(15.sp);
            border-radius: \(24.r)px;
            padding: \(0.5.h) \(8.w);
            background-color: #272F60;
        }
        p {
            font-family: "Montserrat-Regular";
            font-size: \(15.sp);
            color: #272F60;
            text-align: center;
            margin-top: 5px;
            margin-bottom: 0px;
        }
"""
    
    static let goalCss = """
        @font-face {
            font-family: 'Montserrat-Bold';
            src: url("Montserrat-Bold.ttf") format('truetype');
        }
        .primaryRedBg {
            background-color: #FD657C;
            border-radius: \(24.r)px;
            padding: \(0.5.h) \(16.w);
        }
        .primaryBlueBg {
            background-color: #272F60;
            border-radius: \(24.r)px;
            padding: \(0.5.h) \(16.w);
        }
        p {
            font-size: \(25.sp);
            color: #FFFFFF;
            line-height: 160%;
        }
"""
    
    static var attendeeManifestoScreenList : [String] {
        if var names = UtilityMethod().getValueForKey(key: ConstantOfApp.kArrOfAttendeeScreenList) as? [String] {
            if names.last == "QUESTION_DATA_PROCESSING" {
                names.popLast()
                if let index = names.firstIndex(where: {$0 == "QUESTION_PERFECT_WELL_DONE"}) {
                    names.remove(at: index)
                    names.append("QUESTION_DATA_PROCESSING")
                    names.append("QUESTION_PERFECT_WELL_DONE")
                }
            }
            return names
        }
        /// Default values
        return [
            "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME", // 1
            "MANIFESTO_MR_ARTHUR_IS_YOUR_FRIEND", // 2
            "MANIFESTO_MR_ARTHUR_WILL_MAKE_YOU_SMART", // 3
            "MANIFESTO_MAKE_THE_FIRST_STEP_AGAINST_TYRANNY", // 4
            "MANIFESTO_MR_ARTHUR_WILL_EMPOWER_YOU", // 5
            "MANIFESTO_MR_ARTHUR_IS_A_NURSE", // 6
            "MANIFESTO_HOW_KID_WILL_MAKE_A_PROPOSAL", // 7
            "MANIFESTO_ENJOY_FREE_TIME_WITH_BUDDIES", // 8
            "MANIFESTO_LETS_EMBARK", // 9
            "QUESTION_TOO_MUCH_TIME_ON_SCREEN", // 10
            "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1", // 11
            "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2", // 12
            "QUESTION_FAMILY_SCREEN_ARGUMENTS", // 13
            "QUESTION_COURAGE_LITTLE_TIME_LEFT", // 14
            "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES", // 15
            "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES", // 16
            "QUESTION_ENJOY_AND_LEARN", // 17
            "QUESTION_ABOUT_SMART_EDUCATIVE_APPS", // 18
            "QUESTION_DATA_PROCESSING", // 19
            "QUESTION_PERFECT_WELL_DONE" // 20
        ]
    }
    static var attendeeManifestoQuestionList : [String] {
        return [
            "QUESTION_TOO_MUCH_TIME_ON_SCREEN",
            "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1",
            "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2",
            "QUESTION_FAMILY_SCREEN_ARGUMENTS",
            "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES",
            "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES",
            "QUESTION_ENJOY_AND_LEARN",
            "QUESTION_ABOUT_SMART_EDUCATIVE_APPS"
        ]
    }
    
    static var isFrench : Bool {
        let countryCode = getCountryCode()
        return countryCode.lowercased() == "fr"
    }
    
    static func getCountryCode() -> String{
        var countryCode = "\(DeviceService.getDeviceLanguage())"
        if countryCode.lowercased() == "fr"{
            countryCode = "FR"
        } else{
            countryCode = "US"
        }
        return countryCode
    }
    
    static func getTimeStringBySeconds(value: Int) -> String {
        let (h, m, s) = UtilityMethod.secondsToHoursMinutesSeconds(value)
//        return h.toTimeFormate
        if (h < 0 || m < 0 || s < 0) {
            return "-" + abs(h).toTimeFormate + ":" + abs(m).toTimeFormate + ":" + abs(s).toTimeFormate
        } else {
            return h.toTimeFormate + ":" + m.toTimeFormate + ":" + s.toTimeFormate
        }
    }
    
    static func getTimeStringByMinute(value: Int) -> String {
        let (h, m, s) = UtilityMethod.minutesToHoursMinutesSeconds(value)
//        return h.toTimeFormate
        if (h < 0 || m < 0 || s < 0) {
            return "-" + abs(h).toTimeFormate + ":" + abs(m).toTimeFormate + ":" + abs(s).toTimeFormate
        } else {
            return h.toTimeFormate + ":" + m.toTimeFormate + ":" + s.toTimeFormate
        }
    }
    
    static func getMinuteStringFromSecond(second: Int) -> String {
        let minute: Int = Int(ceil(Double(second / 60)))
        return "\(minute) min"
    }
    
    public func saveInDefault(value:Any,key:String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    
    public func getValueForKey(key:String)->Any{
        let objvalue =   UserDefaults.standard.object(forKey: key)
        return objvalue as Any
        
    }
    
    
    public func setData<T>(value: T, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    public func getData<T>(type: T.Type, forKey: String) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey) as? T
        return value
    }
    
    public func removeData(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    public func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func saveQuestion(question: AnswerModel, key: String) {
        if let encoded = try? JSONEncoder().encode(question) {
            setData(value: encoded, key: key)
        } else {
            print("failed to save user")
        }
    }
    
    func getQuestion(key: String) -> AnswerModel? {
        if let data: Data = getData(type: Data.self, forKey: key) {
            return try? APIHelper().decodeStickers(from: data)
        }
        return nil
    }
    
    static func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func minutesToHoursMinutesSeconds(_ minutes: Int) -> (Int, Int, Int) {
        let seconds = minutes * 60
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func secondsToHoursMinutes(_ seconds: Int) -> String {
        let hour = seconds / 3600
        let minutes = seconds % 3600
        if(hour < 10 && minutes < 10){
            return "0\(seconds / 3600)h0\((seconds % 3600) / 60)"
        }else if(hour < 10){
            return "0\(seconds / 3600)h\((seconds % 3600) / 60)"
        }else if(minutes < 10){
            return "\(seconds / 3600)h0\((seconds % 3600) / 60)"
        }else{
            return "\(seconds / 3600)h\((seconds % 3600) / 60)"
        }
    }
    
    static func hoursToSeconds(seperatedby:String,hoursminInString:String)->Int{
        let arrOfTime  = hoursminInString.components(separatedBy: seperatedby)
        let hour = Int(arrOfTime[0]) ?? 0
        let minutes = Int(arrOfTime[1]) ?? 00
        return ((hour * 60) + minutes) * 60
    }
    
    static func changeInTimeAccordingToPercentage(percentage:Int,way:String,TotalSeconds:Int)->(String,Int){
        var ChangedSeconds = TotalSeconds
        let calcualtedseconds = (TotalSeconds * percentage) / 100
        if(way == "Incresed"){
            ChangedSeconds += calcualtedseconds
        }else{
            ChangedSeconds -= calcualtedseconds
        }
        return (self.secondsToHoursMinutes(ChangedSeconds), ChangedSeconds)
    }
    
    static func logoutObserver(completion: @escaping () -> ()){
        AmplitudeService.sendEvent(key: .ATT_PLUS_LOG_OUT_MAIL_1_CONFIRM)
        clearSession()
        IntercomMessageService().logoutUser()
        completion()
    }
    static func clearSession(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func getViewCreatedAtAndUpdatedDate(dateString : String) -> String {
        if let dDOB = dateString.convertUTCStringToDate(dateFormat: "yyyy-MM-dd'T'hh:mm:ss.SSSZ") {
            let localDate = dDOB.toLocalTime()
            print("localDate -----> \(dDOB.toLocalTime())")
            print("getChildCreatedAtDate -----> \(localDate.getFormattedDate(format: "dd/MM/yyyy"))")
            return localDate.getFormattedDate(format: "dd/MM/yyyy")
        }
        return Date().getFormattedDate(format: "dd/MM/yyyy")
    }
    
    static func getManifestoQuestionList(_ sender: EUserType) -> [AnswerModel]{
        return load(sender == .OBSERVER_USER ? "Question_Parent.json" : "Question_attendee.json")
    }
    
    private static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func appIconGet(_ link:  String, completion: @escaping(UIImage?) -> Void ){
        if let image = loadImageFromCache(link) {
            completion(image)
        } else {
            DispatchQueue.global(qos: .background).async {
                let appMainUrl = link
                let finalAppID = appMainUrl.split(separator: "/")
                if let lastElement = finalAppID.last {
                    let idString = lastElement
                    let numericIDStr = (idString as NSString).substring(from: 2)
                    let urlStr = "http://itunes.apple.com/lookup?id=\(numericIDStr)"
                    let urlApp = URL(string: urlStr)
                    
                    if let theProfileImageUrl = urlApp {
                        do {
                            let json = try Data(contentsOf: theProfileImageUrl as URL)
                            var dict: [AnyHashable : Any]? = nil
                            do {
                                dict = try JSONSerialization.jsonObject(with: json, options: []) as? [AnyHashable : Any]
                            } catch {
                                completion(nil)
                            }
                            let results = dict?["results"] as? [AnyHashable]
                            let result = results?[0] as? [AnyHashable : Any]
                            let imageUrlStr = result?["artworkUrl60"] as? String
                            let artworkURL = URL(string: imageUrlStr ?? "")
                            var imageData: Data? = nil
                            if let artworkURLs = artworkURL {
                                imageData = try Data(contentsOf: artworkURLs)
                            }
                            if let imgData = imageData {
                                DispatchQueue.main.async {
                                    if let img = UIImage(data: imgData) {
                                        completion(img)
                                        self.imageCache.set(forKey: link, image: img)
                                    } else {
                                        completion(nil)
                                    }
                                }
                            } else {
                                completion(nil)
                            }
                        } catch {
                            print("Unable to load data: \(error)")
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    private func loadImageFromCache(_ urlString: String) -> UIImage? {
        guard let cacheImage = self.imageCache.get(forKey: urlString) else {
            return nil
        }
        return cacheImage
    }

}

func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if !ENV_PROD
    Swift.print(items, separator: separator, terminator: terminator)
    #endif
}
