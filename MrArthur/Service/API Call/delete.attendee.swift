//
//  delete.attendee.swift
//  MrArthur
//
//  Created by Nirav Patel on 06/10/22.
//

import Foundation
struct DeleteAttendeeRequesModel:Codable {
    var attendeeUUID:String
}
struct DeleteAttendeeAPICall{
    
    func deleteAttendee(parameter:[String:Any],completion:@escaping(String, Bool)->()){
        let strAttendeeUDID =  String.init(format: "\(UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? "")")
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.deleteAttendeeURL + strAttendeeUDID,
            methodName: .delete,
            param: parameter,
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
           
            completion("", true)
        } fail: { error in
            completion(error, false)
        }
    }
}
