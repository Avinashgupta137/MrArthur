//
//  CreateAttende.swift
//  MrArthur
//
//  Created by IPS-169 on 25/07/22.
//

import Foundation
struct CreateAttendeeCall{

    func createAttendee(
        param:[String:Any],
        completion:@escaping(String?,CreateAttendeeResponseModel?)->()
    ) {
        APIHelper().callAPI(
            URLString: (ConstantHttp.createAttendeeURL) ,
            methodName: .post,
            param: param,
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
            if let attendee : CreateAttendeeResponseModel = try? APIHelper.shared.decodeStickers(from: data){
                UtilityMethod().setData(
                    value: attendee.id,
                    key: ConstantOfApp.kAttendeeUUID
                )
                UtilityMethod().saveInDefault(
                    value: attendee.attendeeUserUUID,
                    key: ConstantOfApp.kAttendeeUUID
                )
                UtilityMethod().saveInDefault(
                    value: attendee.attendeeUserMediationUUID,
                    key: ConstantOfApp.kMediationUDID
                )
                completion(nil,attendee)
            } else {
                completion("Can not decode the model",nil)
            }
            
        } fail: { errorMsg in
            completion(errorMsg,nil)
        }
    }
}
