//
//  CreateAttende.swift
//  MrArthur
//
//  Created by Sébastien Reille on 19/08/22.
//

import Foundation

struct RegisterDeviceParameters: Codable {
    var appIdentifier: String
    var name: String
    var model: String
    var language: ELanguage
    var iCloudUserRecordId: String?
    var timeZoneSecondsFromGMT: Int?
}

struct SetDeviceTokenParameters: Codable {
    var appIdentifier: String
    var pushNotificationToken: String
}

struct DeviceApiCall {
    
    func register(
        param: RegisterDeviceParameters,
        completion: @escaping (String?, DeviceResponseModel?) -> ()
    ) {
        if let parameters: [String: Any] = try? param.asDictionary(){
            
            if let token = CurrentUserService.getToken() {
                APIHelper().callAPI(
                    URLString: (ConstantHttp.deviceRegisterURL),
                    methodName: .post,
                    param: parameters,
                    withToken: token
                ) { data in
                    let resData = Data(data)
                    if let resData: DeviceResponseModel = try? APIHelper.shared.decodeStickers(from: resData) {
                        completion(nil, resData)
                    } else {
                        completion("Can not decode the model", nil)
                    }
                } fail: { errorMessage in
                    print("Fail to register device with error: \(errorMessage)")
                    completion(errorMessage, nil)
                }
            }
        }
    }
    
    func setToken(
        param: SetDeviceTokenParameters,
        completion: @escaping (String?, DeviceResponseModel?) -> ()
    ) {
        if let parameters: [String: Any] = try? param.asDictionary() {
            
            if let token = CurrentUserService.getToken() {
                APIHelper().callAPI(
                    URLString: (ConstantHttp.deviceSetTokenURL),
                    methodName: .post,
                    param: parameters,
                    withToken: token
                ) { data in
                    let resData = Data(data)
                    if let resData: DeviceResponseModel = try? APIHelper.shared.decodeStickers(from: resData) {
                        completion(nil, resData)
                    } else {
                        completion("Can not decode the model", nil)
                    }
                } fail: { errorMessage in
                    completion(errorMessage, nil)
                }
            }
        }
    }
}
