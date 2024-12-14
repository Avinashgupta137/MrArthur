//
//  attendeeLoginAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 01/08/22.
//

import Foundation
struct AttendeeLoginAPICall{
    func request(completion:@escaping(String?,AttendeeLoginResponseModel?)->()){
        let attendeeUDID =  UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? ""
        print("Attendee UDID: \(attendeeUDID)")
        let strAttendeeLogin = "\(attendeeUDID)/login"
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.attendeeLoginURL + strAttendeeLogin,
            methodName: APICallMethodType.get,
            param: [String:Any](),
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
            print("Data of Attendee: - \(data)")
            let stickerData = Data(data)
            if let attendeeLoginResponseObj : AttendeeLoginResponseModel = try? APIHelper.shared.decodeStickers(from: stickerData){
                UserDefaultsHelper.selectedAttendee = attendeeLoginResponseObj.user
                completion("", attendeeLoginResponseObj)
            }else{
                completion("can not decode model",nil)
            }
        } fail: { errorMsg in
            let error = errorMsg
            completion(error,nil)
        }
    }
}
