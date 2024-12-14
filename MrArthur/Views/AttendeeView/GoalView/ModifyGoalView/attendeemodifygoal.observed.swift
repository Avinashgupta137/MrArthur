//
//  attendeemodifygoal.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 22/08/22.
//

import Foundation
import SwiftUI


class ModifyGoalObserved:ObservableObject{
    
    @Published var sReducedTotalScreenTime = "00h00"
    @Published var sEducationalTotalScreenTime = "00h00"
    
    @Published var goalEndAngel: Double = 20
    
    @Published var autoReduceEnabled: Bool = true
    @Published var autoEducationalEnabled: Bool = true
    
    @Published var reduceEnabled: Bool = true
    @Published var educationalEnabled: Bool = true
    
    @Published var mrText: String = ""
    @Published var mrImage: String = ""
    
    var iReducedTotalScreenTimePercent: Int = 0
    var iEducationalTotalScreenTimePercent: Int = 0
    
    var iReducedTotalScreenTime: Int = 0
    var iEducationalTotalScreenTime: Int = 0
    
    var iDiagnosedScreenTimeMinutes: Int = 0
    var initReducedTotalScreenTimePercent: Int = 0
    var initEducationalTotalScreenTimePercent: Int = 0
    
    let startdAngel:Double = 20
    let endAngel:Double = 160
    
    init() {
        MediationService().fetchMediationInfo { message, res, status in
            if let data = res.stepListJsonb?.list?.last {
                self.iReducedTotalScreenTimePercent = data.totalTimeReductionPercent ?? 0
                self.iEducationalTotalScreenTimePercent = data.educativeTimePercent ?? 0
            }
            if let estimation = res.stepListJsonb?.estimation {
                if let diagnosedScreenTimeMinutes = estimation.diagnosedScreenTimeMinutes {
                    self.iDiagnosedScreenTimeMinutes = diagnosedScreenTimeMinutes
                    self.initReducedTotalScreenTimePercent = self.iReducedTotalScreenTimePercent
                    self.initEducationalTotalScreenTimePercent = self.iEducationalTotalScreenTimePercent
                    self.setInitReducedTotalScreenTime()
                }
            }
        }
        self.mrText = "You can do better! Believe me, you will be proud of yourself.".localized
        self.mrImage = "MrArthurIAQuiteHappyFace"
    }
    
    private func setInitReducedTotalScreenTime() {
        let screenTime = self.iDiagnosedScreenTimeMinutes
        let percentage = self.iReducedTotalScreenTimePercent
        let calculation: Double = 1.0 - (Double(percentage)/100)
        self.iReducedTotalScreenTime = Double(Double(screenTime)  * calculation).toCeilInt
        self.setEducationalScreenTime()
    }
    
    private func setEducationalScreenTime() {
        let screenTime = self.iReducedTotalScreenTime
        let percentage = self.iEducationalTotalScreenTimePercent
        let calculation: Double = Double(screenTime) * (Double(percentage)/100)
        self.iEducationalTotalScreenTime = calculation.toCeilInt
        setProgress()
    }
    
    private func setProgress() {
        let angle = ((endAngel - startdAngel) * Double(self.iEducationalTotalScreenTime)) / Double(self.iReducedTotalScreenTime)
        goalEndAngel = angle + startdAngel
        self.setTimeLabel()
    }
    
    private func setTimeLabel() {
        let (rh,rm,_) = UtilityMethod.minutesToHoursMinutesSeconds(self.iReducedTotalScreenTime)
        self.sReducedTotalScreenTime = rh.toTimeFormate + "h" + rm.toTimeFormate
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(self.iEducationalTotalScreenTime)
        self.sEducationalTotalScreenTime = h.toTimeFormate + "h" + m.toTimeFormate
    }
    
    func autoIncreaseReducedTotalScreenTimePercent() {
        self.autoReduceEnabled = false
        let proposal = self.initReducedTotalScreenTimePercent
        print("proposal \(proposal)")
        
        var addBy: Int = 0
        
        if (proposal >= 5 && proposal <= 10) {
            addBy = 10
        } else if (proposal >= 10 && proposal <= 20) {
            addBy = 8
        } else if (proposal >= 20 && proposal <= 30) {
            addBy = 5
        } else if (proposal >= 30 && proposal <= 40) {
            addBy = 4
        } else if (proposal >= 40 && proposal <= 50) {
            addBy = 2
        }
        let value = proposal + addBy
        self.reduceScreenTimeBy(value)
    }
    
    private func reduceScreenTimeBy(_ to: Int) {
        print("iReducedTotalScreenTimePercent \(iReducedTotalScreenTimePercent)")
        self.reduceEnabled = to <= 50
        if self.iReducedTotalScreenTimePercent <= 50 {
            let percent = to
            self.iReducedTotalScreenTimePercent = percent <= 50 ? percent : 50
            self.setInitReducedTotalScreenTime()
            self.setImageAndText()
        }
    }
    
    func reduceScreenTimeBy5() {
        self.autoReduceEnabled = true
        let value = self.iReducedTotalScreenTimePercent + 5
        self.reduceScreenTimeBy(value)
    }
    
    func autoIncreaseEducationalTotalScreenTimePercent() {
        self.autoEducationalEnabled = false
        let proposal = self.initEducationalTotalScreenTimePercent
        
        var addBy: Int = 0
        
        if (proposal >= 5 && proposal <= 10) {
            addBy = 10
        } else if (proposal >= 10 && proposal <= 20) {
            addBy = 5
        } else if (proposal >= 20 && proposal <= 30) {
            addBy = 3
        } else {
            addBy = 2
        }
        let value = proposal + addBy
        self.incEducationalScreenTimeBy(value)
    }
    
    private func incEducationalScreenTimeBy(_ to: Int) {
        print("iEducationalTotalScreenTimePercent \(iEducationalTotalScreenTimePercent)")
        self.educationalEnabled = to <= 50
        if self.iEducationalTotalScreenTimePercent <= 50 {
            let percent = to
            self.iEducationalTotalScreenTimePercent = percent <= 50 ? percent : 50
            self.setEducationalScreenTime()
            self.setImageAndText()
        }
    }
    
    func incEduicationalScreenTimeBy5() {
        self.autoEducationalEnabled = true
        let value = self.iEducationalTotalScreenTimePercent + 5
        self.incEducationalScreenTimeBy(value)
    }
    
    func resetScreenTimes() {
        AmplitudeService.sendEvent(
            key: .OBS_CO_8_RESET
        )
        self.reduceEnabled = true
        self.educationalEnabled = true
        self.autoEducationalEnabled = true
        self.autoReduceEnabled = true
        self.iReducedTotalScreenTimePercent = self.initReducedTotalScreenTimePercent
        self.iEducationalTotalScreenTimePercent = self.initEducationalTotalScreenTimePercent
        self.setInitReducedTotalScreenTime()
        self.mrText = "You can do better! \nBelieve me, you will be proud of yourself.".localized
        self.mrImage = "MrArthurIAQuiteHappyFace"
    }
    
    func sendGoal(completion: @escaping() -> ()) {
        AmplitudeService.sendEventWithData(
            key: .OBS_CO_8_SEND,
            data: [
                "goalScreenTime" : sEducationalTotalScreenTime,
                "totalScreenTime": sReducedTotalScreenTime
            ]
        )
        print("goalScreenTime && totalScreenTime: - \(sEducationalTotalScreenTime) - \(sReducedTotalScreenTime)")
        let editmediationrequest = AddStepMediationRequestModel.init(
            totalTimeReductionPercent: self.iReducedTotalScreenTimePercent,
            educativeTimePercent: self.iEducationalTotalScreenTimePercent
        )
        print("param of edit mediation = \(editmediationrequest)")
        if let param = try? editmediationrequest.asDictionary(){
            AddMediationStepAPICall().addStep(param: param) { errormsg, addstepresponse in
                if let err = errormsg{
                    if(err.count == 0){
                        UtilityMethod().setData(
                            value: ConstantOfApp.kMediationUnderApproval,
                            key: ConstantOfApp.kStatusOfMeditation
                        )
                        completion()
                    } else {
                        print("message = \(err)")
                    }
                }
            }
        }
    }
    
    private func setImageAndText() {
        let (label, image) = GoalDetailService.getTextImageForWorst(
            reducedPercentage: self.iReducedTotalScreenTimePercent,
            educationIncPercent: self.iEducationalTotalScreenTimePercent,
            forChild: true
        )
        self.mrText = label
        self.mrImage = image
    }
}

