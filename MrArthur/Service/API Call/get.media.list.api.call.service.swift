//
//  get.media.list.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 17/09/22.
//

import Foundation

struct GetMediaListAPICall {
    func getList(
        completion: @escaping (Bool, String?, GetMediaListResponseModel?) -> ()
    ) {
        
        var countryCode = "\(DeviceService.getDeviceLanguage())"
        if countryCode.lowercased() == "fr"{
            countryCode = "FR"
        } else{
            countryCode = "US"
        }

        if let token = CurrentUserService.getToken() {
            APIHelper().callAPI(
                    URLString: ConstantHttp.getListOfMediaURL + countryCode,
                    methodName: .get,
                    param: [:],
                    withToken: token
            ) { data in
                if let model: GetMediaListResponseModel = try? APIHelper.shared.decodeStickers(from: data) {
                    completion(true, nil, model)
                } else {
                    completion(false, "Can not decode the model", nil)
                }
            } fail: { error in
                print("Fail to register device with error: \(error)")
                completion(false, error, nil)
            }
        } else {
            completion(false, "Token not found", nil)
        }
    }
    
}
