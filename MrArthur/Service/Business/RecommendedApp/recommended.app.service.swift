//
//  recommanded.app.service.swift
//  MrArthur
//
//  Created by IPS-157 on 17/09/22.
//

import Foundation

class RecommededAppService{
    static func getList(Completion: @escaping(Bool, String, [RecommandedAppListResponseModel]) -> ()){
        GetRecommendedAppListAPICall().getList { status, message, appListModel in
            Completion(status, message, appListModel)
        }
    }
}
