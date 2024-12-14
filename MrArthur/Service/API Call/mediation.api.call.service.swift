//
//  mediation.api.call.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 09/11/2022.
//

import Foundation

struct MediationApiCallService {
    let myGroup = DispatchGroup()
   
    func getLatestAcceptedMediation(
        completion: @escaping(String, MediationDetailResponseModel?, Bool)->()
    ) {
        var msg = ""
        self.myGroup.enter()
        var mediation: MediationDetailResponseModel?
        var status: Bool = false
        let param = [String:Any]()
        
        if let token = CurrentUserService.getToken() {
            APIHelper().callAPI(
                    URLString: (ConstantHttp.getLatestAcceptedMediation),
                    methodName: .get,
                    param: param,
                    withToken: token
            ) { data in
                let resData = Data(data)
                if let resData: MediationDetailResponseModel = try? APIHelper.shared.decodeStickers(from: resData) {
                    mediation = resData
                    status = true
                } else {
                    msg = "Can not decode the model"
                    status = false
                }
                self.myGroup.leave()
            } fail: { errorMessage in
                msg = errorMessage
                status = false
                print("Fail to get latest accepted mediation with error: \(msg)")
                self.myGroup.leave()
            }
            myGroup.notify(queue: DispatchQueue.main) {
                completion(msg, mediation, status)
            }
        }
    }
}
