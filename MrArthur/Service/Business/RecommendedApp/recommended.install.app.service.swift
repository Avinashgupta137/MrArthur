//
//  recommended.install.app.service.swift
//  MrArthur
//
//  Created by IPS-157 on 17/09/22.
//

import Foundation
class RecommededInstallAppService{
    static func addList(appUdid:String, Completion: @escaping(Bool, String?, [InstallAppResponseModel]?) -> ()){
        let param = AddInstalledAppRequestParameterModel(recommendedMobileApplicationUUID: appUdid)
        AddInstalledAppAPICall().addinstalledApp(parameter: param) { status, message, addInstallAppinList in
//            print("Resopnse of RecommededApp List: \(addInstallAppinList)")
            Completion(status, message, addInstallAppinList)
        }
    }
    static func getList(Completion: @escaping(Bool, String, [InstallAppResponseModel]) -> ()){
        GetInstalledAppListAPICall().getinstalledApp { status, message, installedAppList in
//            print("Resopnse of RecommededApp List: \(installedAppList)")
            Completion(status, message, installedAppList)
        }
    }
}
