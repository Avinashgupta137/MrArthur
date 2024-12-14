//
//  AttendeeCreateGoalIncreaseView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 10/08/22.
//

import Foundation
import SwiftUI

class AttendeeEducation:ObservableObject{
    @Published var sEducationScreenTimePerDay = "00h00"
    @Published var sTotalScreenTimePerDay = "00h00"
    @Published var isActive = false
    @Published var position : Float = 0
    var iTotalScreenTimeReduced: Int = 0
    @Published var numberOfEducationTime = 0
    @Published var totalNewLang = ""
    var iIncreasedPercentage: Int = 0
    var iIncreasedTime: Int = 0
    
    func _init (iTotalScreenTimeReduced: Int) {
        self.iTotalScreenTimeReduced = iTotalScreenTimeReduced
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(self.iTotalScreenTimeReduced)
        self.sTotalScreenTimePerDay = h.toTimeFormate + "h" + m.toTimeFormate
        self.iIncreasedPercentage = 5
        setEducationalTime()
    }
    
    private func setEducationalTime() {
        let calculation: Double = Double(self.iTotalScreenTimeReduced) * (Double(self.iIncreasedPercentage)/100)
        self.iIncreasedTime = calculation.toCeilInt
        
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(self.iIncreasedTime)
        self.sEducationScreenTimePerDay = h.toTimeFormate + "h" + m.toTimeFormate
        checkNewLang()
    }
    
    func checkNewLang(){
        var value = 0
        if self.iIncreasedTime > 0 {
            value = 7300 / self.iIncreasedTime / 30
        }
         totalNewLang = "learned in ".localized + "\(value)" + " months".localized
    }
    
    func checkTotalNewLanguage(totalTime:Int){
        if 7300 < (totalTime * 30) {
            let finalMonth = (totalTime * 30) / 7300
            print("Final Month :\(finalMonth)")
        }
        else{
            let finalMonth = 7300 / (totalTime * 30)
            print("Final Month :\(finalMonth)")
            totalNewLang = "\(finalMonth)"
        }
    }
    
    func setTime(percentage: Int) {
        self.iIncreasedPercentage = percentage > 0 ? percentage : 5
        setEducationalTime()
    }
    func getImageByPercentage()->Image{
        let percentage = self.iIncreasedPercentage
        
        if(percentage > 5 && percentage <= 10) {
            return  Image("MrArthurIANotHappyAtAllFace")
        } else if(percentage > 10 && percentage <= 20) {
            return Image("MrArthurIAHappyFace")
        } else if(percentage > 20 && percentage <= 30) {
            return Image("MrArthurIASuperHappyFace")
        } else if(percentage > 30 && percentage <= 50) {
            return Image("MrArthurIAAstonishedFace")
        } else {
            return Image("MrArthurIANotHappyAtAllFace")
        }
    }
    
    func getTextByPercentage()->String{
        let percentage = self.iIncreasedPercentage
        var txt = "It’s just not enough... your parents will never accept this !"
        if(percentage > 5 && percentage <= 10) {
            txt = "It’s just not enough... your parents will never accept this !"
        } else if(percentage > 10 && percentage <= 20) {
            txt = "Nice, you are getting there, your parents might accept your goal !"
        } else if(percentage > 20 && percentage <= 30) {
            txt = "Great, that’s a terrific goal, I bet your parents will proudly accept it !"
        } else if(percentage > 30 && percentage <= 50) {
            txt = "Wow that’s amazing, you really want to change your life for the best, your parents are going to be so proud of you !"
        }
        
        return txt.localized
    }
    
    func getHtmlString(
    ) -> String {
        return """
        <p>\("Increase your".localized)<br>
            <span class="primaryBlueBg">\("educational screen time.".localized)</span>
            \(UtilityMethod.isFrench ? "quotidien." : "")<br>
        </p>
"""
    }

        
}
