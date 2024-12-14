//
//  attendee.appsettings.observed.swift
//  MrArthur
//
//  Created by Amit Sinha on 17/11/22.
//

import Foundation
extension AttendeeAppsettingsView{
    class ObservedParentingSetUp:ObservableObject{
        var arrOfRecommandedAppData:[RecommandedAppListResponseModel] = []
        
        init() {
            self.getRecommendedAppList { _, _, recommanededAppList in
                print("Response of All List:-> \(recommanededAppList) Education App")
            }
        }
        
        func getRecommendedAppList(completion: @escaping (Bool, String, [RecommandedAppListResponseModel])-> () ) {
            RecommededAppService.getList { status, message, recommendedAppList in
                self.arrOfRecommandedAppData = recommendedAppList
                print("Array of Recommanded Data: \(self.arrOfRecommandedAppData) , count = \(self.arrOfRecommandedAppData.count)")
                completion (status, message, recommendedAppList)
            }
        }
    }
}
