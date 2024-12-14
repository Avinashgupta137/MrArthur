//
//  ApproveMeditation.swift
//  MrArthur
//
//  Created by IPS-169 on 10/08/22.
//

import Foundation
struct ApproveMediationAPICall{
    
    
    func approveMediationInfo(acceptStatus:Bool,completion:@escaping(String?,MediationApprovalResponseModel?)->()){
        var errormessage = ""
        var mediationResponseObj = MediationApprovalResponseModel.init(uuid: "", stepListJsonb: MediationApprovalStepListJsonbResponseModel.init(estimation: MediationApprovalEstimationResponseModel.init(totalScreenTimeMinutes: 0, dailyTVMinutes: 0, dailyVideoGamMinutes: 0, dailySharedScreenTimeMinutes: 0, dailyOwnSmartPhoneMinutes: 0, dailyOwnTabletMinutes: 0, dailyEducativeTimeMinutes: 0, increasePercent: 0), list: [MediationApprovalListResponseModel]()), createdAt: "", updatedAt: "", attendeeUserUUID: "")
        let approveMediationRequest = ApproveMediationRequestModel.init(accepted: acceptStatus)
        let  param = try! approveMediationRequest.asDictionary()
       
        APIHelper.shared.callAPI(urlString: ConstantHttp.approveMediationUrl, methodName: .put, param: param, withToken: ConstantOfApp.kselectedAttendeeQuestion) { data in

            let stickerData = Data(data)
            if let mediationresponseObj : MediationApprovalResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
         
                let meditationObj = MediationApprovalResponseModel.init(uuid: mediationresponseObj.uuid, stepListJsonb: mediationresponseObj.stepListJsonb, createdAt: mediationresponseObj.createdAt, updatedAt: mediationresponseObj.updatedAt, attendeeUserUUID: mediationresponseObj.uuid)
                print("meditation info response = \(meditationObj)")
                mediationResponseObj = meditationObj
            }else{
                errormessage = "Can not decode the model"
            }
            completion(errormessage,mediationResponseObj)
        } fail: { msgerror in
            let error = msgerror
            errormessage = error as! String
            print("error is = \(errormessage)")
            completion(errormessage,mediationResponseObj)
        }
       
    }
}
