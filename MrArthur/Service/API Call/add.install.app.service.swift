//
//  install.app.service.swift
//  MrArthur
//
//  Created by IPS-157 on 17/09/22.
//

import Foundation

struct AddInstalledAppRequestParameterModel: Codable {
    let recommendedMobileApplicationUUID:String
}

struct AddInstalledAppAPICall{
    func addinstalledApp(
        parameter: AddInstalledAppRequestParameterModel,
        completion: @escaping (Bool, String?, [InstallAppResponseModel]?) -> ()
    ) {
        if let parameters = try? parameter.asDictionary() {
            if let token = CurrentUserService.getToken() {
                APIHelper().callAPI(
                        URLString: (ConstantHttp.installrecommendedAppURL),
                        methodName: .post,
                        param: parameters,
                        withToken: token
                ) { data in
                    let resData = Data(data)
                    if let model: [InstallAppResponseModel] = try? APIHelper.shared.decodeStickers(from: resData) {
                        completion(true, nil, model)
                    } else {
                        completion(false, "Can not decode the model", nil)
                    }
                } fail: { error in
                    print("Fail to register device with error: \(error)")
                    completion(false, error, nil)
                }
            }
        }
    }
}
