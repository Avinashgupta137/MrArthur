//
//  MeditationFetchInfoAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 08/08/22.
//

import Foundation
struct MediationFetchInfoAPICall{
   
    func fetchMediationInfo(acceptStatus:Bool,completion:@escaping(String?,MediationDetailResponseModel?)->()){
        var errorMessage = ""
        var mediationResponseObj = MediationDetailResponseModel.init(uuid: "", stepListJsonb: StepListMeditationJsonbResponseModel.init(list: [MediationListResponseModel](), estimation: MediationEstimationResponseModel.init()), createdAt: "", updatedAt: "", attendeeUserUUID: "")
        let param = [String:Any]()
        APIHelper.shared.callAPI(urlString: ConstantHttp.attendeeMediationDetailUrl, methodName: .get, param: param, withToken: ConstantOfApp.kobserverTokenSend) { data in
            
            let stickerData = Data(data)
            if let mediationresponseObj : MediationDetailResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                
                let mediationObj = MediationDetailResponseModel.init(uuid: mediationresponseObj.uuid, stepListJsonb: mediationresponseObj.stepListJsonb, createdAt: mediationresponseObj.createdAt, updatedAt: mediationresponseObj.updatedAt, attendeeUserUUID: mediationresponseObj.uuid)
                print("meditation info response = \(mediationObj)")
                mediationResponseObj = mediationObj
            }else{
                print("can not decode model")
                errorMessage = "can not decode model"
            }
            completion(errorMessage,mediationResponseObj)
        } fail: { errorMsg in
            let error = errorMsg
            errorMessage = error as! String
            print("error is = \(errorMessage)")
            completion(errorMessage,mediationResponseObj)
        }
    
    }
}
