//
//  MeditationFetchInfoAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 08/08/22.
//

import Foundation
struct MediationFetchInfoAPICall{
   
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
        APIHelper.shared.callAPI(URLString: ConstantHttp.attendeeMediationDetailURL, methodName: .get, param: param, withToken: ConstantOfApp.kObserverTokenSend) { data in
            
            let stickerData = Data(data)
            if let mediationResponseObj : MediationDetailResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                
                let mediationObj = MediationDetailResponseModel.init(
                    uuid: mediationResponseObj.uuid,
                    entertainmentScreenTimeSecondAllowed: mediationResponseObj.entertainmentScreenTimeSecondAllowed,
                    educationalScreenTimeSecondCommitment: mediationResponseObj.educationalScreenTimeSecondCommitment,
                    stepListJsonb: mediationResponseObj.stepListJsonb,
                    createdAt: mediationResponseObj.createdAt,
                    updatedAt: mediationResponseObj.updatedAt,
                    attendeeUserUUID: mediationResponseObj.uuid
                )
                print("fetch meditation info response = \(mediationObj)")
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
}
