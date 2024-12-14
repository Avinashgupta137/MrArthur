//
//  app.time.model.swift
//  MrArthur
//
//  Created by IPS-157 on 14/09/22.
//

import Foundation
let sTimeDefault = UserDefaults.standard
let sTotalScreenTime = "TotalScreenTime"

class AppTimeModel : NSCoder,Codable {
    var totalScreenTime :  String = "0"
    var educationTime : String = "0"
    var remaingTime : String = "0"
    var currentTime : String = ""
    var lastUpdateTime : String = ""
    
    override init(){}
    
    init(TotalScreenTime: String, EducationTime: String, CurrentTime : String) {
        super.init()
        self.totalScreenTime = TotalScreenTime
        self.educationTime = EducationTime
        self.currentTime = CurrentTime
    }
    
    init(TotalScreenTime: String, EducationTime: String,RemainTime :  String, CurrentTime : String) {
        super.init()
        self.totalScreenTime = TotalScreenTime
        self.educationTime = EducationTime
        self.remaingTime = RemainTime
        self.currentTime = CurrentTime
    }
}
