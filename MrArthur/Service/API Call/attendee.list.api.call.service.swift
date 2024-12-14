//
//  File.swift
//  MrArthur
//
//  Created by IPS-169 on 26/07/22.
//

import Foundation
struct AttendeeListAPICall{
    
    func attendeeListapiCall(
        parameter:[String:Any],
        completion:@escaping(String?,[AttendeeListResponseModel]?)->()
    ) {
        let strAttendeeListURL = String.init(format: "\(UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String ?? "")/attendee-user")
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.attendeeListURL + strAttendeeListURL,
            methodName: APICallMethodType.get,
            param: parameter,
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
            let stickerData = Data(data)
            UserDefaultsHelper.currentUserAttenseeListData = stickerData
            if let list : [AttendeeListResponseModel] = try? APIHelper.shared.decodeDataToModel(from: stickerData){
                completion(nil,list)
            } else {
                completion("Can not decode the model",nil)
            }
            
        } fail: { error in
            completion(error,nil)
        }
    }
}

