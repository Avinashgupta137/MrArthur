//
//  attendee.pairingsetup.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 29/08/22.
//

import Foundation
extension AttendeePairingSetUpView{
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
