//
//  MeditationInfoHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 09/08/22.
//

import Foundation
import SwiftUI
class MediationService{
    
    @AppStorage("self.statusOfMeditation", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var statusOfMediation : String = ""
    
    func getMediation(completion:@escaping(String,MediationDetailResponseModel,Bool)->()){
        fetchMediationInfo { errorMessage, mediation,statusOfApi  in
            if(statusOfApi){
                self.getStatusOfMediation(mediationResponse: mediation)
                completion(errorMessage,mediation,statusOfApi)
            }else{
                print(errorMessage)
            }
        }
    }
    
    func getStatusOfMediation(mediationResponse:MediationDetailResponseModel){
        
        if(mediationResponse.stepListJsonb?.list?.count == 0){
            
            self.statusOfMediation = ConstantOfApp.kMediationNotCreated
            UtilityMethod().saveInDefault(value: self.statusOfMediation, key: ConstantOfApp.kStatusOfMeditation)
            
        }else if(mediationResponse.stepListJsonb?.list?.count ?? 0 > 0){
            
            if  let firstMediation = mediationResponse.stepListJsonb?.list?.last{
                
                if (firstMediation.accepted ==  true) {
                    self.statusOfMediation = ConstantOfApp.kMediationApproved
                    UtilityMethod().saveInDefault(value: self.statusOfMediation, key: ConstantOfApp.kStatusOfMeditation)
                    
                }else if (firstMediation.accepted == false) {
                    self.statusOfMediation = ConstantOfApp.kMediationRejected
                    UtilityMethod().saveInDefault(value: self.statusOfMediation, key: ConstantOfApp.kStatusOfMeditation)
                }
                else if(firstMediation.educativeTimePercent == 0 && firstMediation.totalTimeReductionPercent == 0 ){
                    self.statusOfMediation = ConstantOfApp.kMediationUnderApproval
                    UtilityMethod().saveInDefault(value: self.statusOfMediation, key: ConstantOfApp.kStatusOfMeditation)
                    
                }else{
                    self.statusOfMediation = ConstantOfApp.kMediationUnderApproval
                    UtilityMethod().saveInDefault(value: self.statusOfMediation, key: ConstantOfApp.kStatusOfMeditation)
                }
                
            }else{
                self.statusOfMediation = ConstantOfApp.kMediationNotCreated
                UtilityMethod().saveInDefault(value: self.statusOfMediation, key: ConstantOfApp.kStatusOfMeditation)
            }
        }
        
    }
    
    func fetchMediationInfo(completion:@escaping(String,MediationDetailResponseModel,Bool)->()){
        var errorMessage = ""
        var mediationResponseObject = MediationDetailResponseModel.init(
            uuid: "",
            entertainmentScreenTimeSecondAllowed: 0,
            educationalScreenTimeSecondCommitment: 0,
            stepListJsonb: StepListMeditationJsonbResponseModel.init(
                list: [MediationListResponseModel](),
                estimation: MediationEstimationResponseModel.init()
            ),
            createdAt: "",
            updatedAt: "",
            attendeeUserUUID: ""
        )
        let param = [String:Any]()
        let url = ConstantHttp.attendeeMediationDetailURL + (UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID) as? String ?? "")
        APIHelper.shared.callAPI(
            URLString: url,
            methodName: .get,
            param: param,
            withToken: ConstantOfApp.kObserverTokenSend
        )
        { data in
            
            let stickerData = Data(data)
            if let mediationResponseObj : MediationDetailResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                
                let mediationObj = MediationDetailResponseModel.init(
                    uuid: mediationResponseObj.uuid,
                    entertainmentScreenTimeSecondAllowed: mediationResponseObj.entertainmentScreenTimeSecondAllowed,
                    educationalScreenTimeSecondCommitment: mediationResponseObj.educationalScreenTimeSecondCommitment,
                    stepListJsonb: mediationResponseObj.stepListJsonb,
                    createdAt: mediationResponseObj.createdAt,
                    updatedAt: mediationResponseObj.updatedAt,
                    attendeeUserUUID: mediationResponseObj.attendeeUserUUID
                )
                print("fetch meditation = \(mediationObj)")
               
                if let latestStepGoalDetail = mediationObj.stepListJsonb?.list?.first {
                    if let mediationStatus = latestStepGoalDetail.accepted{
                        if(mediationStatus ==  true){
                            UtilityMethod().saveInDefault(value: ConstantOfApp.kMediationApproved, key: ConstantOfApp.kStatusOfMeditation)
                        }else{
                            
                            UtilityMethod().saveInDefault(value: ConstantOfApp.kMediationRejected, key: ConstantOfApp.kStatusOfMeditation)
                        }
                    }else{
                        UtilityMethod().saveInDefault(value: ConstantOfApp.kMediationUnderApproval, key: ConstantOfApp.kStatusOfMeditation)
                    }
                }else{
                    UtilityMethod().saveInDefault(value: ConstantOfApp.kMediationNotCreated, key: ConstantOfApp.kStatusOfMeditation)
                }
                mediationResponseObject = mediationObj
            }else{
                print("can not decode model")
                errorMessage = "can not decode model"
            }
            completion(errorMessage,mediationResponseObject,true)
        } fail: { errorMsg in
            let error = errorMsg
            errorMessage = error
            print("error is = \(errorMessage)")
            completion(errorMessage,mediationResponseObject,false)
        }
    }
    
    func handleLatestAcceptedMediation() {
        MediationApiCallService().getLatestAcceptedMediation() { errorMessage, mediation, status in
            if let safeMediation = mediation {
                let entertainementSecond: Int = ExtensionEntertainmentService.getEntertainmentSTSecondPerDayAllowed()
                if (entertainementSecond == 0 || entertainementSecond != safeMediation.entertainmentScreenTimeSecondAllowed) {
                    if let safeSecond = safeMediation.entertainmentScreenTimeSecondAllowed {
                        ExtensionEntertainmentService.setEntertainmentSTSecondPerDayAllowed(second: safeSecond)
                    }
                }
                
                let educationalSecond: Int = ExtensionEducationalService.getEducationalSTSecondPerDayCommitment()
                if (educationalSecond == 0 || educationalSecond != safeMediation.educationalScreenTimeSecondCommitment) {
                    if let safeSecond = safeMediation.educationalScreenTimeSecondCommitment {
                        ExtensionEducationalService.setEducationalSTSecondPerDayCommitment(second: safeSecond)
                    }
                }
            }
            
            let screenTimeProcessOnGoing: Bool = ExtensionDeviceActivityService.isScreenTimeProcessOnGoing()
//            print("screen time process on going ? \(screenTimeProcessOnGoing)")
            if (!screenTimeProcessOnGoing) {
                ExtensionDeviceActivityService.stopMonitoringAllActivities()
                ExtensionDeviceActivityService.scheduleActivityRestPeriod()
                ExtensionDeviceAcivitySlotService.scheduleSlotActivities()
                ExtensionEntertainmentService.setMorningAdvance()
                let _ = ExtensionScreenTimePermissionService.getEntertainmentScreenTimeSecondLeftToday()
            } else {
//                let timeLeft: Int = ExtensionScreenTimePermissionService.getEntertainmentScreenTimeSecondLeftToday()
//                if (!ExtensionRestPeriodService.isInRestPeriod() && timeLeft > 0) {
//                    let entertainementActivityOngoing: Bool = ExtensionDeviceActivityService.isScreenTimeEntertainementActivityOnGoing()
//                    let educationalActivityOngoing: Bool = ExtensionDeviceActivityService.isScreenTimeEducationalActivityOnGoing()
//                    if (!entertainementActivityOngoing) {
//                        ExtensionDeviceActivityService.scheduleEntertainmentActivity()
//                    }
//                    if (!educationalActivityOngoing) {
//                        ExtensionDeviceActivityService.scheduleEducationalActivity()
//                    }
//                }
                // another idea is to check if the start morning date is the same has yesterday
            }
        }
    }
}
