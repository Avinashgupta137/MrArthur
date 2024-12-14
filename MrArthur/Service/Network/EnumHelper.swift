//
//  EnumHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 06/07/22.
//

import Foundation
enum APICallMethodType {
    case get
    case post
    case patch
    case put
    case delete
}
enum StateOfQuestion{
    case answerPending
    case answerGiving
    case answerGiven
    case none
}
enum AppIsUsedBy : String{
    case observer
    case attendee
}

enum EScreenSizeFor {
    case WIDTH
    case HEIGHT
}
enum ParentalControlPreset{
    case FROM8
    case FROM16
    case FROM32
    case NOT_SET_YET
}

enum EPreviewDevices: String {
    case iPad_Pro_12_9_inch_5th_generation = "iPad Pro (12.9-inch) (5th generation)"
    case iPhone_14_Pro_Max = "iPhone 14 Pro Max"
    case iPhone_14_Pro = "iPhone 14 Pro"
    case iPhone_14 = "iPhone 14"
    case iPhone_8 = "iPhone 8"
}
