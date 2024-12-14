//
//  edit.attendee.swift
//  MrArthur
//
//  Created by IPS-172 on 21/10/22.
//

import Foundation

struct EditAttendeeRequesModel:Codable {
    var attendeeName:String
    var gender:String
    var birthDate:String
}
struct EditAttendeeAPICall{
    
    func editAttendee(
        parameter: [String:Any]?,
        completion: @escaping(String?, Bool, EditProfileResponseModel?) -> ()
    ) {
        if let attendeeUserUUID = UserDefaultsHelper.selectedAttendee?.uuid as? String {
            APIHelper.shared.callAPI(
                URLString: ConstantHttp.editAttendeeURL + attendeeUserUUID,
                methodName: .put,
                param: parameter,
                withToken: ConstantOfApp.kObserverTokenSend
            ) { data in
                if let model: EditProfileResponseModel = try? APIHelper.shared.decodeStickers(from: data) {
                    completion(nil, true, model)
                } else {
                    completion("Can not decode the model", false, nil)
                }
                
            } fail: { error in
                print("Fail to register device with error: \(error)")
                completion(error, false, nil)
            }
        } else {
            completion("Attendee UUID not found", false, nil)
        }
    }
}
