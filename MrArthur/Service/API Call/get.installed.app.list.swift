//
//  get.installed.app.list.swift
//  MrArthur
//
//  Created by IPS-157 on 19/09/22.
//

import Foundation

//RecommendedAppListJSONBResponseModel
struct GetInstalledAppListAPICall{
    let myGroup = DispatchGroup()
    func getinstalledApp(
        completion: @escaping (Bool,String, [InstallAppResponseModel]) -> ()
    ) {
        let parameters: [String: Any] = [String:Any]()
        var status = false
        var msg = ""
        var installedAppList: [InstallAppResponseModel]?
        myGroup.enter()
        if let token = CurrentUserService.getToken() {
            APIHelper().callAPI(
                    URLString: (ConstantHttp.installrecommendedAppURL),
                    methodName: .get,
                    param: parameters,
                    withToken: token
            ) { data in
                status = true
                let resData = Data(data)
                if let resData: [InstallAppResponseModel] = try? APIHelper.shared.decodeStickers(from: resData) {
                    installedAppList = resData
                } else {
                    msg = "Can not decode the model"
                }
               myGroup.leave()
            } fail: { errorMessage in
                status = false
                msg = errorMessage
                print("Fail to register device with error: \(msg)")
               myGroup.leave()
            }

            myGroup.notify(queue: DispatchQueue.main) {
                completion(status,msg, installedAppList ?? [InstallAppResponseModel]())
            }
        }
    }
}
