//
//  GetAttendeeScreenTimeApiCall.swift
//  MrArthur
//
//  Created by IPS-169 on 24/08/22.
//

import Foundation
struct GetAttendeeScreenTimeAPICall{
    
    func request(param:[String:Any],completion:@escaping(String?,ScreenTimeEstimateResponseModel?)->()){
        var errorMessage = ""
        var screenResponseObj = ScreenTimeEstimateResponseModel.init(totalScreenTimeMinutes: 0, dailyTVMinutes: 0, dailyVideoGameMinutes: 0, dailySharedScreenTimeMinutes: 0, dailyOwnSmartPhoneMinutes: 0, dailyOwnTabletMinutes: 0, dailyEducativeTimeMinutes: 0, increasePercent: 0, diagnosedScreenTimeMinutes: 0)
        
        let modelAttendeeScreenTimeEstimate = ScreenTimeRequestModel.init(mediationUUID: UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID) as? String ?? "")
        print("mediation uuid = \(UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID))")
        let strURL = UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID) as? String ?? "" + "mediation-step/new"
        if let param = try? modelAttendeeScreenTimeEstimate.asDictionary() {
            APIHelper.shared.callAPI(URLString: ConstantHttp.getScreenEstimateTimeURL + strURL, methodName: APICallMethodType.get,param: param, withToken: ConstantOfApp.kObserverTokenSend) { data in
                
                let stickerData = Data(data)
                
                if let screenTimeEstimateResponseObj : ScreenTimeEstimateResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                    let screenTimeEstimateResponse = ScreenTimeEstimateResponseModel.init(totalScreenTimeMinutes: screenTimeEstimateResponseObj.totalScreenTimeMinutes, dailyTVMinutes: screenTimeEstimateResponseObj.dailyTVMinutes, dailyVideoGameMinutes: screenTimeEstimateResponseObj.dailyVideoGameMinutes, dailySharedScreenTimeMinutes: screenTimeEstimateResponseObj.dailySharedScreenTimeMinutes, dailyOwnSmartPhoneMinutes: screenTimeEstimateResponseObj.dailyOwnSmartPhoneMinutes, dailyOwnTabletMinutes: screenTimeEstimateResponseObj.dailyOwnTabletMinutes, dailyEducativeTimeMinutes: screenTimeEstimateResponseObj.dailyEducativeTimeMinutes, increasePercent: screenTimeEstimateResponseObj.increasePercent, diagnosedScreenTimeMinutes: screenTimeEstimateResponseObj.diagnosedScreenTimeMinutes)
                    screenResponseObj = screenTimeEstimateResponse
                }else{
                    print("can not decode model")
                    errorMessage = "can not decode model"
                }
                completion(errorMessage,screenResponseObj)
            } fail: { errorMsg in
                let error = errorMsg
                errorMessage = error
                print("error is = \(errorMessage)")
                completion(errorMessage,screenResponseObj)
            }
        }
        
    }
}
