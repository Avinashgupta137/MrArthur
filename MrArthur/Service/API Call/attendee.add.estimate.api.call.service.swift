//
//  AttendeeAddEstimateAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 16/08/22.
//

import Foundation
struct AttendeeAddEstimateAPICall{
  
    func addEstimate(param:[String:Any],completion:@escaping(String?,AddupEstimateResponseModel?)->()){
        var errorMessage = ""
        var estimateResponseObject = AddupEstimateResponseModel.init(dailyTVMinutes: 0, dailyVideoGamMinutes: 0, dailyOwnTabletMinutes: 0, totalScreenTimeMinutes: 0, dailyOwnSmartPhoneMinutes: 0, dailySharedScreenTimeMinutes: 0, dailyEducativeTimeMinutes: 0)

        APIHelper.shared.callAPI(URLString: ConstantHttp.attendeeAddEstimateURL, methodName: .post, param: param, withToken: ConstantOfApp.kObserverTokenSend) { data in
        
            let stickerData = Data(data)

            if let estimateResponseObj : AddupEstimateResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                let meditationObj = AddupEstimateResponseModel.init(dailyTVMinutes: estimateResponseObj.dailyTVMinutes, dailyVideoGamMinutes: estimateResponseObj.dailyVideoGamMinutes, dailyOwnTabletMinutes: estimateResponseObj.dailyOwnTabletMinutes, totalScreenTimeMinutes: estimateResponseObj.totalScreenTimeMinutes, dailyOwnSmartPhoneMinutes: estimateResponseObj.dailyOwnSmartPhoneMinutes, dailySharedScreenTimeMinutes: estimateResponseObj.dailySharedScreenTimeMinutes, dailyEducativeTimeMinutes: estimateResponseObj.dailyEducativeTimeMinutes)
                print("add meditation info response = \(meditationObj)")
                estimateResponseObject = meditationObj
            }else{
                print("can not decode model")
                errorMessage = "can not decode model"
            }
            completion(errorMessage,estimateResponseObject)
        } fail: { errorMsg in
            let error = errorMsg
            errorMessage = error
            print("error is = \(errorMessage)")
            completion(errorMessage,estimateResponseObject)
        }
        
    }
}
