//
//  TextModifier.swift
//  MrArthur
//
//  Created by Troo on 21/07/22.
//

import SwiftUI

enum FontStyle: String {
    case montserratRegular = "Montserrat-Regular"
    case montserratBold = "Montserrat-Bold"
    case montserratBoldItalic = "Montserrat-BoldItalic"
    case montserratExtraBold = "Montserrat-ExtraBold"
    case montserratExtraBoldItalic = "Montserrat-ExtraBoldItalic"
    case montserratBlack = "Montserrat-Black"
    case montserratBlackItalic = "Montserrat-BlackItalic"
    case montserratItalic = "Montserrat-Italic"
    case montserratVariableFontwght = "Montserrat-VariableFontwght"
}
public var  iPhoneFont21 = CGFloat(21)
public var  iPhoneFont28 = CGFloat(28)
public var  iPhoneFont25 = CGFloat(25)
public var  iPhoneFont22 = CGFloat(22)
public var  iPhoneFont20 = CGFloat(20)
public var  iPhoneFont15 = CGFloat(15)
public var  iPhoneFont11 = CGFloat(11)
public var  iPhoneFont12 = CGFloat(12)
public var  iPhoneFont18 = CGFloat(18)
public var  iPhoneFont147 = CGFloat(14.7)
public var  iPhoneFont13 = CGFloat(13)
public var  iPhoneFont50 = CGFloat(50)
public var  iPhoneFont40 = CGFloat(40)
public var  iPhoneFont10 = CGFloat(10)


extension UIFont {
    
    func montserratBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: FontStyle.montserratBold.rawValue, size: size.sp)
    }
}

extension Text {
    
    func fontModifier(font: FontStyle, size: CGFloat, kerning: CGFloat = 0, color: Color = .white)-> Text {
        let isIphone8 : Bool = UIDevice.current.name == "iPhone 8"
        var dSize = size
        if isiPad() {
            dSize += 13
        } else if isIphone8 {
            dSize -= (size > 15) ? 3 : 0
        }
        let text = self
            .foregroundColor(color)
            .font(.custom(font.rawValue, size: size.sp))
        //text.lineSpacing(35)
        
        return text.kerning(kerning)
    }
//    func fontModifier_2(font: FontStyle, size: CGFloat, kerning: CGFloat = 0, color: Color = .white)-> Text {
//        let xdSize = (width: CGFloat(428), height: CGFloat(926))
//        let screenSize = UIScreen.screenSize
//        var dSize = size
//        if xdSize.width < screenSize.width {
//            // increase by
//            let percent = ((screenSize.width * 100)/xdSize.width) - 100
//            let incBy = (percent * size) / 100
//            print("incBy", incBy, "percent", percent, "size", size)
//            dSize = size + incBy
//        } else {
//            // decrease by
//            let percent = 100 - ((screenSize.width * 100)/xdSize.width)
//            let decBy = (percent * size) / 100
//            dSize = size - decBy
//        }
//        print("screenSize", screenSize, "dSize", dSize)
//        let text =
//      self
//            .foregroundColor(color)
//            .font(.custom(font.rawValue, size: dSize))
//        
//        return text.kerning(kerning)
//            
//        
//    }
    
}
