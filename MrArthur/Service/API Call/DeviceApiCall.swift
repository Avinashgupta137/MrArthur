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
    var iCloudUserRecordId: String?
}

struct SetDeviceTokenParameters: Codable {
    var appIdentifier: String
    var pushNotificationToken: String
}

struct DeviceApiCall {
    

    func register(param: RegisterDeviceParameters, completion: @escaping (String?, DeviceResponse?) -> ()) {
        let parameters: [String: Any] = try! param.asDictionary()
        var msg = ""
        var device: DeviceResponse? // = DeviceResponse.init(uuid: "", : "", attendeeUserUUID: "")
        APIHelper().callAPI(
                urlString: (ConstantHttp.DeviceRegisterUrl),
                methodName: .post,
                param: parameters,
                withToken: ConstantOfApp.kparenttokensend
        ) { data in
            let resData = Data(data)
            if let resData: DeviceResponse = try? APIHelper.shared.decodeStickers(from: resData) {
                device = resData
            } else {
                msg = "Can not decode the model"
            }
            completion(msg, device)
        } fail: { errormessage in
            msg = errormessage
            completion(msg, device)
        }

    }
}
