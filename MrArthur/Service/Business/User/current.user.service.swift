//
//  current.user.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 19/08/2022.
//

import Foundation

struct CurrentUserInformation {
    var uuid, anonymousICloudId: String
    var email, observerEmail, observerUUID: String?
    var type: EUserType
}

class CurrentUserService {
    static let shared = CurrentUserService()
    var user: CurrentUser?
    
    public static func getToken() -> String? {
        KeychainService.getKeychainValue(key: .CURRENT_USER_TOKEN)
    }
    
    public static func setToken(token: String) -> Bool {
        let tokenSaved: Bool = KeychainService.setKeychainValue(key: .CURRENT_USER_TOKEN, value: token)
        CurrentUserService.shared.getMe(reloadFromApi: true) { _ in }
//        print("new current Token = \(token) and status is = \(tokenSaved)")
        return tokenSaved
    }

    public func getMe(reloadFromApi: Bool, completion: @escaping (CurrentUser?) -> ()) {
        
        if (reloadFromApi || self.user == nil) {
            UserApiCallService().getMe() { errorMessage, user in
                if let currentUser = user {
//                    print("[CurrentUserService][getMe]")
//                    dump(currentUser)
                    self.setMe(currentUser: currentUser)
                    completion(currentUser)
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(self.user)
        }
    }

    public func setMe(currentUser: CurrentUser) -> Void {
        self.user = currentUser
    }
    
    public func getBasicInformation(completion: @escaping(CurrentUserInformation?) -> ()) {
        self.getMe(reloadFromApi: !self.hasSignedUp()) { currentUser in
//            dump("CURRENT USER basic info \(currentUser)")
            if let attendee = currentUser?.attendeeUser {
                completion(CurrentUserInformation(
                    uuid: attendee.uuid,
                    anonymousICloudId: CloudKitService.getAnonymousIcloudId(),
                    email: attendee.intercomEmail,
                    observerEmail: UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverEmail) as? String ?? nil,
                    observerUUID: UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverUUID) as? String ?? nil,
                    type: attendee.type
                ))
            } else if let observer = currentUser?.observerUser {
                completion(CurrentUserInformation(
                    uuid: observer.uuid,
                    anonymousICloudId: CloudKitService.getAnonymousIcloudId(),
                    email: observer.contact?.email ?? nil,
                    observerEmail: observer.contact?.email ?? nil,
                    observerUUID: observer.uuid ?? nil,
                    type: observer.type
                ))
            } else {
                completion(nil)
            }
        }
    }
    
    func hasSignedUp() -> Bool {
        return self.user != nil && self.user?.observerUser != nil && self.user?.observerUser?.contact?.email != ""
    }
    
//    public func isAttendee() -> Bool {
//        let user: CurrentUser = self.getMe(reloadFromApi: , completion: )
//    }
}
