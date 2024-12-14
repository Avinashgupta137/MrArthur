//
//  user.api.call.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 23/08/2022.
//

import Foundation

struct UserApiCallService {
    func getMe(
        completion: @escaping (String?, CurrentUser?) -> ()
    ) {
        var currentUser: CurrentUser?
        if let token = CurrentUserService.getToken() {
            APIHelper().callAPI(
                URLString: (ConstantHttp.userGetMeURL),
                methodName: .get,
                param: [String: Any](),
                withToken: token
            ) { data in
                let nilVal: Any? = nil
                if let resData: ObserverCurrentUser = try? APIHelper.shared.decodeDataToModel(from: data), resData.type == EUserType.OBSERVER_USER {
                    currentUser = (observerUser: resData, attendeeUser: nilVal) as? CurrentUser
                } else if let resData: AttendeeCurrentUser = try? APIHelper.shared.decodeDataToModel(from: data), resData.type == EUserType.ATTENDEE_USER {
                    currentUser = (observerUser: nilVal, attendeeUser: resData) as? CurrentUser
                }
//                dump("GETME USER \(data)")
                completion("", currentUser)
            } fail: { errorMessage in
//                dump("GETME Error Message \(errorMessage)")
                completion(errorMessage, currentUser)
            }
            
        }
    }
}
