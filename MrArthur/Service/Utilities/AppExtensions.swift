//
//  AppExtensions.swift
//  MrArthur
//
//  Created by IPS-169 on 08/07/22.
//

import Foundation
import UIKit
import SwiftUI

private let ipadFontIncBy: CGFloat = 15
private let iphon8DecBy: CGFloat = 3
private let isIphone8 : Bool = UIDevice.current.name == "iPhone 8"
//W - 428px
//H - 926px
extension Int {
    
    var resizable: CGFloat {
        let incBy: CGFloat = isiPad() ? ipadFontIncBy : 0
        let decBy :CGFloat = isIphone8 ? iphon8DecBy : 0
        return (CGFloat(self) + incBy) - decBy
    }
    
    var toTimeFormate: String {
        return String(format: "%02d", self)
    }
    
    func iPadIncBy(_ value: Int) -> Int {
        return isiPad() ? (self + value) : self
    }
    
    var iPadIncBy_5 : Int {
        return isiPad() ? (self + 5) : self
    }
    
    var iPadIncBy_10 : Int {
        return isiPad() ? (self + 10) : self
    }
    
    var iPadIncBy_15 : Int {
        return isiPad() ? (self + 15) : self
    }
    
    var iPadIncBy_20 : Int {
        return isiPad() ? (self + 20) : self
    }
    
    var iPadIncBy_25 : Int {
        return isiPad() ? (self + 25) : self
    }
    
    var iPadIncBy_30 : Int {
        return isiPad() ? (self + 30) : self
    }
    
    var iPadIncBy_35 : Int {
        return isiPad() ? (self + 35) : self
    }
    
    var iPadIncBy_40 : Int {
        return isiPad() ? (self + 40) : self
    }
    
    var iPadIncBy_45 : Int {
        return isiPad() ? (self + 45) : self
    }
    
    var iPadIncBy_50 : Int {
        return isiPad() ? (self + 50) : self
    }
}

extension Double {
    
    var toCeil: Double {
        return ceil(self)
    }
    
    var toCeilInt: Int {
        return Int(ceil(self))
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var resizable: CGFloat {
        let incBy: CGFloat = isiPad() ? ipadFontIncBy : 0
        let decBy :CGFloat = isIphone8 ? iphon8DecBy : 0
        return (CGFloat(self) + incBy) - decBy
    }
    
    func iPadIncBy(_ value: Double) -> Double {
        return isiPad() ? (self + value) : self
    }
    
    var iPadIncBy_5 : Double {
        return isiPad() ? (self + 5) : self
    }
    
    var iPadIncBy_10 : Double {
        return isiPad() ? (self + 10) : self
    }
    
    var iPadIncBy_15 : Double {
        return isiPad() ? (self + 15) : self
    }
    
    var iPadIncBy_20 : Double {
        return isiPad() ? (self + 20) : self
    }
    
    var iPadIncBy_25 : Double {
        return isiPad() ? (self + 25) : self
    }
    
    var iPadIncBy_30 : Double {
        return isiPad() ? (self + 30) : self
    }
    
    var iPadIncBy_35 : Double {
        return isiPad() ? (self + 35) : self
    }
    
    var iPadIncBy_40 : Double {
        return isiPad() ? (self + 40) : self
    }
    
    var iPadIncBy_45 : Double {
        return isiPad() ? (self + 45) : self
    }
    
    var iPadIncBy_50 : Double {
        return isiPad() ? (self + 50) : self
    }
}

extension CGFloat {
    
    var toCeil: CGFloat {
        return ceil(self)
    }
    
    var resizable: CGFloat {
        let incBy: CGFloat = isiPad() ? ipadFontIncBy : 0
        let decBy :CGFloat = isIphone8 ? iphon8DecBy : 0
        return (self + incBy) - decBy
    }
    
    static func dynamicValueByScreenPercent(
        by: EScreenSizeFor,
        foriPhone: CGFloat? = nil,
        foriPad: CGFloat? = nil
    ) -> CGFloat {
        let value = by == .WIDTH ? UIScreen.screenWidth : UIScreen.screenHeight
        let iPhoneValue = value * (foriPhone ?? 1)
        let iPadValue = value * (foriPad ?? 1)
        return isiPad() ? iPadValue : iPhoneValue
    }
    
    static func dynamicValue(foriPhone: CGFloat, foriPad: CGFloat) -> CGFloat {
        return isiPad() ? foriPad : foriPhone
    }
    
    func iPadIncBy(_ value: CGFloat) -> CGFloat {
        return isiPad() ? (self + value) : self
    }
    
    var iPadIncBy_5 : CGFloat {
        return isiPad() ? (self + 5) : self
    }
    
    var iPadIncBy_10 : CGFloat {
        return isiPad() ? (self + 10) : self
    }
    
    var iPadIncBy_15 : CGFloat {
        return isiPad() ? (self + 15) : self
    }
    
    var iPadIncBy_20 : CGFloat {
        return isiPad() ? (self + 20) : self
    }
    
    var iPadIncBy_25 : CGFloat {
        return isiPad() ? (self + 25) : self
    }
    
    var iPadIncBy_30 : CGFloat {
        return isiPad() ? (self + 30) : self
    }
    
    var iPadIncBy_35 : CGFloat {
        return isiPad() ? (self + 35) : self
    }
    
    var iPadIncBy_40 : CGFloat {
        return isiPad() ? (self + 40) : self
    }
    
    var iPadIncBy_45 : CGFloat {
        return isiPad() ? (self + 45) : self
    }
    
    var iPadIncBy_50 : CGFloat {
        return isiPad() ? (self + 50) : self
    }
}

extension Color {
    static var primaryRed = Color("primary_Red")
    static var primaryBlue = Color("primary_Blue")
    static var secondaryRed = Color("secondary_Red")
    static var backgroundOffWhite = Color("back_OffWhite")
    static var secondaryBlue = Color("secondary_Blue")
    static var primaryOrange = Color("primary_Orange")
    static var thirdRed = Color("third_Red")
    static var validateGreen = Color("validate_Green")
    static var lightPink = Color("light_Pink")
    static var forthRed = Color("forth_Red")
    static var statusBarColor = Color("secondary_Red")
    static var whiteColor = Color("white_Color")
    static var blackColor = Color("black_Color")
    static var navigationBarColor = Color("secondary_Red")
    static var primaryYellow = Color("primary_yellow")
    static var progressGray = Color("progress_gray")
    static var paringSetupBackground = Color("paring_setup_background")
    static var thirdBlue = Color("third_blue")
    static var backgroundGrey = Color("background_gray")
    
}

extension UIColor {
    static var primaryRed = UIColor(named: "primary_Red")
    static var primaryBlue = UIColor(named: "primary_Blue")
    static var secondaryRed = UIColor(named: "secondary_Red")
    static var secondaryBlue = UIColor(named: "secondary_Blue")
    static var primaryOrange = UIColor(named: "primary_Orange")
    static var thirdRed = UIColor(named: "third_Red")
    static var validateGreen = UIColor(named: "validate_Green")
    static var lightPink = UIColor(named: "light_Pink")
    static var forthRed = UIColor(named: "forth_Red")
    static var statusBarColor = UIColor(named: "secondary_Red")
    static var whiteColor = UIColor(named: "white_Color")
    static var blackColor = UIColor(named: "black_Color")
    static var navigationBarColor = UIColor(named: "secondary_Red")
    static var paringSetupBackground = UIColor(named: "paring_setup_background")
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension String {
    
    func getSize() -> CGFloat{
        let font = UIFont(name: "Montserrat-Bold", size: 16.sp)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes as [NSAttributedString.Key : Any])
        return size.width
    }
   
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func isEqualToString(find: String) -> Bool {
            return String(format: self) == find
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    public func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func trimmingLeadingAndTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
}

extension TextField{
    public func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any] else {
            print("Cannot convert Encodable/Codable to [String: Any]")
            dump(self)
            throw NSError()
        }
        return dictionary
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
