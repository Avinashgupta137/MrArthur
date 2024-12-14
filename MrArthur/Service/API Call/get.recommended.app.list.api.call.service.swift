//
//  get.recommended.app.list.api.call.service.swift
//  MrArthur
//
//  Created by IPS-157 on 17/09/22.
//

import Foundation

//RecommendedAppListJSONBResponseModel
struct GetRecommendedAppListAPICall{
    func getList(
        completion: @escaping (Bool,String, [RecommandedAppListResponseModel]) -> ()
    ) {
        let parameters: [String: Any] = [String:Any]()
        var countryCode = "\(DeviceService.getCountryCode())"
        if countryCode.lowercased() == "fr" {
            countryCode = "FR"
        } else{
            countryCode = "US"
        }
        if CurrentUserService.getToken() != nil {
            APIHelper().callAPI(
                URLString: ConstantHttp.getRecommendedAppURL + countryCode,
                methodName: .get,
                param: parameters,
                withToken: ConstantOfApp.kObserverTokenSend
            ) { data in
                if let resData: [RecommandedAppListResponseModel] = try? APIHelper.shared.decodeStickers(from: data) {
                    completion(true,"", resData)
                } else {
                    completion(false,"Can not decode the model", [])
                }
            } fail: { errorMessage in
                print("Fail to register device with error: \(errorMessage)")
                completion(false, errorMessage, [])
            }
        }
    }
}
