//
//  AttendeeCreateGoalView+Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 05/08/22.
//

import Foundation
import SwiftUI


extension AttendeeCreateGoalView{
    class Observed:ObservableObject{
        
    }
}
class CreateAttendeeGoal:ObservableObject{
    @Published var reducedPercentage = 0
    @Published var titleComic = "0 comics"
    @Published var titleRide = "0 miles\nbike rides"
    @Published var titleAfternoon = "0 afternoons"
    @Published var reducedTime = "00h00"
    @Published var isConfirmActive : Bool = false
    @Published var isImproveActive : Bool = false
    var iSmartPhoneMinutes: Int = 0
    var iTabletMinutes: Int = 0
    var iEducationalAppMinutes: Int = 0
    var numberOfSaveMinute = 0
    var totalScreenTimeBeforeGoal = 0
    var totalScreenTimeAfterGoal = 0
    var iReducedTime = 0
    
    init () {
        if let attendee = UserDefaultsHelper.selectedAttendee {
            if let estimation = attendee.attendeeUserMediationList?.last?.stepListJsonb?.estimation {
                self.iSmartPhoneMinutes = estimation.dailyOwnSmartPhoneMinutes ?? 0
                self.iTabletMinutes = estimation.dailyOwnTabletMinutes ?? 0
                self.iEducationalAppMinutes = estimation.dailyEducativeTimeMinutes ?? 0
                self.totalScreenTimeBeforeGoal = estimation.diagnosedScreenTimeMinutes ?? 0
                let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(self.totalScreenTimeBeforeGoal)
                self.reducedTime = h.toTimeFormate + "h" + m.toTimeFormate
                self.iReducedTime = self.totalScreenTimeBeforeGoal
                self.setTime(percentage: 5)
            }
        }
    }
    
    
    func getImageByPercentage()->Image{
        let percentage = self.reducedPercentage
        
        if(percentage > 5 && percentage <= 10) {
            return  Image("MrArthurIANotHappyAtAllFace")
        } else if(percentage > 10 && percentage <= 20) {
            return Image("MrArthurIAQuiteHappyFace")
        } else if(percentage > 20 && percentage <= 30) {
            return Image("MrArthurIAHappyFace")
        } else if(percentage > 30 && percentage <= 40) {
            return Image("MrArthurIASuperHappyFace")
        } else if(percentage > 40 && percentage <= 50) {
            return Image("MrArthurIAAstonishedFace")
        } else {
            return Image("MrArthurIANotHappyAtAllFace")
        }
    }
    
    func getTextByPercentage()->String{
        let percentage = self.reducedPercentage
        var txt = "It’s just not enough... your parents will never accept this !"
        if(percentage > 5 && percentage <= 10) {
            txt = "It’s just not enough... your parents will never accept this !"
        } else if(percentage > 10 && percentage <= 20) {
            txt = "Not bad, but probably not enough for your parents, you can do better !"
        } else if(percentage > 20 && percentage <= 30) {
            txt = "Nice, you are getting there, your parents might accept your goal !"
        } else if(percentage > 30 && percentage <= 40) {
            txt = "Great, that’s a terrific goal, I bet your parents will proudly accept it !"
        } else if(percentage > 40 && percentage <= 50) {
            txt = "Wow that’s amazing, you really want to change your life for the best, your parents are going to be so proud of you !"
        }
        
        return txt.localized
    }
    
    
    func increasedHour(percentage:Int,totalHour:String)->(sIncreaseTime : String, iIncreaseTime : Int){
        let totalseconds = UtilityMethod.hoursToSeconds(seperatedby: "h", hoursminInString: totalHour)
        let value = UtilityMethod.changeInTimeAccordingToPercentage(percentage: percentage, way: "Incresed", TotalSeconds: totalseconds)
        return (sIncreaseTime : value.0, iIncreaseTime : value.1)
    }
    
    func setTime(percentage: Int) {
        
        self.reducedPercentage = percentage
        let calculation: Double = 1.0 - (Double(percentage)/100)
        self.totalScreenTimeAfterGoal = Double(
            Double(self.totalScreenTimeBeforeGoal)  * calculation
        ).toCeilInt
        self.numberOfSaveMinute = abs(totalScreenTimeBeforeGoal - totalScreenTimeAfterGoal)
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(totalScreenTimeAfterGoal)
        self.iReducedTime = totalScreenTimeAfterGoal
        self.reducedTime = h.toTimeFormate + "h" + m.toTimeFormate
        self.isImproveActive = !(percentage > 20)
        self.isConfirmActive = true
        self.checkComic()
        self.checkTotalRides()
        self.checkTotalAfternoon()
        print("Reduced Percentage:\(percentage)",
              "totalScreenTimeBeforeGoal \(totalScreenTimeBeforeGoal)",
              "totalScreenTimeAfterGoal \(totalScreenTimeAfterGoal)",
              "numberOfSaveMinute:\(numberOfSaveMinute)"
        )
    }
    
    func checkComic(){
        let totalComicValue: Double = Double(numberOfSaveMinute * 365/45)
        let numberOfTotalComic = roundToOneDecimalPlace(totalComicValue)
        print("numberOfTotalComic: \(numberOfTotalComic)")
        let comicTitle = "\(numberOfTotalComic)" + " " + "comics".localized
        titleComic = comicTitle
    }
    
    func checkTotalRides(){
        let totalRideValue: Double = Double(numberOfSaveMinute * 365/60)
        let numberOfTotalRide = roundToOneDecimalPlace(totalRideValue)
        print("numberOfTotalRide: \(numberOfTotalRide)")
        let rideTitle = "\(numberOfTotalRide)" + " " + "miles/\nbike rides".localized
        titleRide = rideTitle
    }
    
    func checkTotalAfternoon(){
        let totalAfternoonValue: Double = Double(numberOfSaveMinute * 365/120)
        let numberOfTotalAfternoon = roundToOneDecimalPlace(totalAfternoonValue)
        print("numberOfTotalAfternoon: \(numberOfTotalAfternoon)")
        let AfternoonTitle = "\(numberOfTotalAfternoon)" + " " + "afternoons".localized
        titleAfternoon = AfternoonTitle//"\(numberOfTotalAfternoon) afternoons"
    }
    
    func roundToOneDecimalPlace(_ x: Double) -> Int {
        let value = Double(round(1 * x) / 1)
        return Int(value)
    }
    
}
