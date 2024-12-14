//
//  attendee.api.service.swift
//  MrArthur
//
//  Created by trootech on 07/10/22.
//

import Foundation

class AttendeeService {
    
    static let shared = AttendeeService()
    
    func getAttendeeByUUID(
        completion:@escaping(String?, AttendeeListResponseModel?)->()
    ) {
        if let attendeeUserUUID = UtilityMethod().getValueForKey(
            key: ConstantOfApp.kAttendeeUUID
        ) as? String {
            
            let url = ConstantHttp.getAttendee + attendeeUserUUID + "/user"
            APIHelper.shared.callAPI(
                URLString: url,
                methodName: .get,
                param: [:],
                withToken: ConstantOfApp.kObserverTokenSend,
                success: { data in
                    if let attendee: AttendeeListResponseModel = try? APIHelper.shared.decodeStickers(from: data) {
                        UserDefaultsHelper.selectedAttendee = attendee
                        UtilityMethod().setData(value: attendee.uuid, key: ConstantOfApp.kAttendeeUUID)
                        completion(nil, attendee)
                    } else {
                        print("getAttendeeByUUID MODEL DECODE FAILED")
                        completion(ConstantOfApp.kErrorDefaultMessage, nil)
                    }
                },
                fail: { error in
                    print("getAttendeeByUUID ERROR : \(error)")
                    completion(error, nil)
                }
            )
        }
    }
}
