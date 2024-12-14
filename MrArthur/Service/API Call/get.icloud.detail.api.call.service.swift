//
//  get.icloud.detail.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation

struct GetiCloudDetailAPICall{
    let myGroup = DispatchGroup()
    
    
    func getiCloudDetail(
        completion: @escaping (String?, ICloudDetailResponse?) -> ()
    ) {
        let parameters: [String: Any] = [String:Any]()
        var msg = ""
        var accountResponse: ICloudDetailResponse? // = DeviceResponse.init(uuid: "", : "", attendeeUserUUID: "")
        myGroup.enter()

        if let token = CurrentUserService.getToken() {
            let strCloudDetail =  String.init(format: "\(CloudKitService.getiCloudAccountUUID())")
            APIHelper().callAPI(
                    URLString: ConstantHttp.getDetailsiCloudAccountURL,
                    methodName: .get,
                    param: parameters,
                    withToken: token
            ) { data in
                let resData = Data(data)
                if let resData: ICloudDetailResponse = try? APIHelper.shared.decodeStickers(from: resData) {
                    accountResponse = resData
                } else {
                    msg = "Can not decode the model"
                }
               myGroup.leave()
            } fail: { errorMessage in
                msg = errorMessage
                print("Fail to register device with error: \(msg)")
               myGroup.leave()
            }

            myGroup.notify(queue: DispatchQueue.main) {
                completion(msg, accountResponse)
            }
        }
    }
}
