//
//  reset.time.model.swift
//  MrArthur
//
//  Created by IPS-169 on 15/09/22.
//

import Foundation
struct RestTimeModel: Codable, Identifiable {
    var id: Int?
    var resetTime: String?
    var imgName:String?
    var isSelected: Bool?
    var restTimeInEnum:EResetTime
    var setedResetTime: Bool {
        get {
            return isSelected ?? false
        }
        set {
            isSelected = newValue
        }
    }
}
