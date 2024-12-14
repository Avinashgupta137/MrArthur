//
//  AddMenifestoStepAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 09/08/22.
//

import Foundation
struct AddMediationStepAPICall {
  
    func addStep(param:[String:Any],completion:@escaping(String?,AddStepMediationResponseModel?)->()){
        var errorMessage  = ""
        var addStepResponse = AddStepMediationResponseModel.init(uuid: "", stepListJsonb: AddMediationStepListJsonbResposeModel.init(list: [AddMediationListResponseModel](), estimation: AddMediationEstimationResponseModel.init()), createdAt: "", updatedAt: "", attendeeUserUUID: "")
        //String.init(format:"\(UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID) as? String ?? "")\(("/mediation-step/new")"))
        let  strAddStepMediation = String.init(format:"\(UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID) as? String ?? "")/mediation-step/new")
        APIHelper().callAPI(URLString: ConstantHttp.addStepMeditationURL + strAddStepMediation, methodName: .patch, param: param, withToken: ConstantOfApp.kAttendeeTokenSend) { data in
            let stickerData = Data(data)
            UserDefaultsHelper.remove(.SELECTED_ATTENDEE)
            if let stepResponse : AddStepMediationResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                addStepResponse = AddStepMediationResponseModel.init(uuid: stepResponse.uuid, stepListJsonb: stepResponse.stepListJsonb, createdAt: stepResponse.createdAt, updatedAt: stepResponse.updatedAt, attendeeUserUUID: stepResponse.attendeeUserUUID)
            }else{
                errorMessage = "Can not decode the model"
            }
            completion(errorMessage,addStepResponse)
        } fail: { errorMsg in
            errorMessage = errorMsg
            completion(errorMsg,addStepResponse)
        }
        
    }
}
