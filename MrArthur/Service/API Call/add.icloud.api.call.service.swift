//
//  add.icloud.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation

struct AddiCloudParameters: Codable {
    
    var userRecordId: String
    var appIdentifier: String
   
}
struct AddiCloudAccountAPICall{
   

//    let myGroup = DispatchGroup()
//    func registeriCloud(
//        param: AddiCloudParameters,
//        completion: @escaping (String?, ICloudCreateResponse?) -> ()
//    ) {
//        let parameters: [String: Any] = try? param.asDictionary()
//        var msg = ""
//        var accountResponse: ICloudCreateResponse? // = DeviceResponse.init(uuid: "", : "", attendeeUserUUID: "")
//        myGroup.enter()
//
//        if let token = CurrentUserService.getToken() {
//            APIHelper().callAPI(
//                    URLString: (ConstantHttp.createicloudAccountURL),
//                    methodName: .post,
//                    param: parameters,
//                    withToken: token
//            ) { data in
//                let resData = Data(data)
//                if let resData: ICloudCreateResponse = try? APIHelper.shared.decodeStickers(from: resData) {
//                    accountResponse = resData
//                } else {
//                    msg = "Can not decode the model"
//                }
//               myGroup.leave()
//            } fail: { errorMessage in
//                msg = errorMessage
//                print("Fail to register device with error: \(msg)")
//               myGroup.leave()
//            }
//
//            myGroup.notify(queue: DispatchQueue.main) {
//                completion(msg, accountResponse)
//            }
//        }
//    }
    
}
