//
//  notification.service.swift
//  MrArthur
//
//  Created by BAPS on 19/10/22.
//

import Foundation

class NotificationHelper {
    static let shared = NotificationHelper()
    
    func installAppOnYourChildPhone(completion: @escaping (ERootView) -> ()) {
        CurrentUserService.shared.getMe(reloadFromApi: true) { _ in
            if let currentUserRole = UtilityMethod().getValueForKey(key: ConstantOfApp.kCurrentUserRole) as? String {
                if currentUserRole == ConstantOfApp.kCurrentUserObserver {
                    self.getAttendeeList { attendees in
                        if attendees.count > 0 {
                            completion(.whichDeviceUsing)
                        } else {
                            completion(.addAttende)
                        }
                    }
                }
            }
        }
        
    }
    
    func helpForAttendeeDeviceSetup(completion: @escaping (ERootView) -> ()) {
        CurrentUserService.shared.getMe(reloadFromApi: true) { _ in
            completion(.attendeePariningSetup)
        }
    }
    
    func attendeeSendYourGoal(isObserver: Bool, completion: @escaping (ERootView) -> ()) {
        CurrentUserService.shared.getMe(reloadFromApi: true) { _ in
            completion(isObserver ? .observerTabBar : .attendeeTabBar)
        }
    }
    
    func goalSent(isObserver: Bool, completion: @escaping (ERootView) -> ()) {
        CurrentUserService.shared.getMe(reloadFromApi: true) { _ in
            completion(isObserver ? .observerTabBar : .attendeeTabBar)
        }
    }
    
    func goalRejected(isObserver: Bool, completion: @escaping (ERootView) -> ()) {
        CurrentUserService.shared.getMe(reloadFromApi: true) { _ in
            completion(isObserver ? .observerTabBar : .attendeeTabBar)
        }
    }
}

extension NotificationHelper {
    private func getAttendeeList(completion: @escaping ([AttendeeListResponseModel]) -> ()) {
        let attendeeListRequest = AttendeeListRequestModel(
            subscriptionUUID: UtilityMethod().getValueForKey(
                key: ConstantOfApp.kUUIDForSubscription
            ) as? String ?? ""
        )
        
        let  param = (try? attendeeListRequest.asDictionary()) ?? [:]
        
        AttendeeListAPICall().attendeeListapiCall(parameter: param) { error, response in
            if let list = response {
                completion(list)
            } else {
                completion([])
            }
        }
    }
}
