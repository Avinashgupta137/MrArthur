//
//  Font.swift
//  MrArthur
//
//  Created by IPS-157 on 07/07/22.
//

import Foundation
import UIKit
import SwiftUI

struct AppFont {
    static func MontserratRegularFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-Regular", size: fontSize)
    }
    static func MontserratBoldFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-Bold", size: fontSize)
    }
    static func MontserratBoldItalicFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-BoldItalic", size: fontSize)
    }
    static func MontserratBlackFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-Black", size: fontSize)
    }
    static func MontserratBlackItalicFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-BlackItalic", size: fontSize)
    }
    static func MontserratItalicVariableFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-Italic-VariableFontwght", size: fontSize)
    }
    static func MontserratVariableFont(fontSize: CGFloat) -> Font {
        return Font.custom("Montserrat-VariableFontwght", size: fontSize)
    }
}

struct FontSize{
    static var iPhoneBigSize = 50
    static var iPadBigSize = 80
    static var iPhoneFontSize = 22
    static var iPadFontSize = 35
    static var iPhoneButtonSize = 15
    static var iPadButtonFontSize = 22
    static var ansiPhoneFont = 17
    static var ansiPad = 25
    static var iPhoneFont15 = 15
    static var iPadFont20 = 20
    static var iPhoneFont20 = 20
    static var iPhoneFont28 = 28
    static var iPadFont38 = 38
    static var iPhoneFont19 = 19
    static var iPhoneFont25 = 25
    static var iPadFont28 = 27
    static let size17: CGFloat = 17
}


