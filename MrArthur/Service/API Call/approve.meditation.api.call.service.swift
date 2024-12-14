//
//  ApproveMeditation.swift
//  MrArthur
//
//  Created by IPS-169 on 10/08/22.
//

import Foundation
struct ApproveMediationAPICall{
    
    func approveMediationInfo(acceptStatus:Bool,completion:@escaping(Bool,String,MediationApprovalResponseModel)->()){
        var errorMessage = ""
        var mediationResponseObject = MediationApprovalResponseModel.init(
            uuid: "",
            stepListJsonb: MediationApprovalStepListJsonbResponseModel.init(
                estimation: MediationApprovalEstimationResponseModel.init(
                    totalScreenTimeMinutes: 0,
                    dailyTVMinutes: 0,
                    dailyVideoGamMinutes: 0,
                    dailySharedScreenTimeMinutes: 0,
                    dailyOwnSmartPhoneMinutes: 0,
                    dailyOwnTabletMinutes: 0,
                    dailyEducativeTimeMinutes: 0,
                    increasePercent: 0
                ),
                list: [MediationApprovalListResponseModel]()),
            createdAt: "",
            updatedAt: "",
            attendeeUserUUID: ""
        )
        
        let approveMediationRequest = ApproveMediationRequestModel.init(accepted: acceptStatus)
        let strURL =  String.init(format:"\(UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID) as? String ?? "")/mediation-step/latest")
        
        if let param = try? approveMediationRequest.asDictionary() {
            APIHelper.shared.callAPI(
                URLString:  ConstantHttp.approveMediationURL +  strURL,
                methodName: .put,
                param: param,
                withToken: ConstantOfApp.kObserverTokenSend
            ) { data in
                UserDefaultsHelper.remove(.SELECTED_ATTENDEE)
                
                let stickerData = Data(data)
                if let mediationResponseObj : MediationApprovalResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                    let meditationObj = MediationApprovalResponseModel.init(
                        uuid: mediationResponseObj.uuid,
                        stepListJsonb: mediationResponseObj.stepListJsonb,
                        createdAt: mediationResponseObj.createdAt,
                        updatedAt: mediationResponseObj.updatedAt,
                        attendeeUserUUID: mediationResponseObj.uuid
                    )
                    print("approve meditation info = \(meditationObj)")
                    mediationResponseObject = meditationObj
                }else{
                    errorMessage = "Can not decode the model"
                }
                completion(true,errorMessage,mediationResponseObject)
            } fail: { msgerror in
                let error = msgerror
                errorMessage = error
                print("error is = \(errorMessage)")
                completion(false,errorMessage,mediationResponseObject)
            }
        }
    }
}
