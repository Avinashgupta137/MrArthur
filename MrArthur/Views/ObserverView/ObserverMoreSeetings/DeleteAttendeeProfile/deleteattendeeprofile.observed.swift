//
//  DeleteAttendeeProfileView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import Foundation
import SwiftUI

extension DeleteAttendeeProfileView{
    class DeleteAttendeeProfileObserved:ObservableObject{
        @Published var attendee = UserDefaultsHelper.selectedAttendee
        func deleteAPI(withToken:String,param:[String:Any],completion:@escaping(String?,Bool)->()){
            let deleteAttendeeparam = DeleteAttendeeRequesModel.init(attendeeUUID: UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? "")
            if let param = try? deleteAttendeeparam.asDictionary() {
                DeleteAttendeeAPICall().deleteAttendee(parameter: param) { message, status in
                    print("Child Deleted: \(message) & Status: \(status)")
                    completion(message, status)
                }
            }
        }
    }
}
