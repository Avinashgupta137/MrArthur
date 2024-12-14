//
//  AddUpSmartAppEstimateView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//

import Foundation
import SwiftUI

extension AddUpSmartAppEstimateView{
    class AddUpSmartAppEstimateObserver: ObservableObject {
        
        var diagnosedScreenTimeMinutes: Int = 0
        var attendeeData: AttendeeListResponseModel = AttendeeListResponseModel()
        
        func addAttendee(completion: @escaping ((Bool) -> Void)) {
            if let createAttendee = UserDefaultsHelper.createAttendee {
                if let param = try? createAttendee.asDictionary() {
                    print("Parameter of add attendee = \(param)")
                    CreateAttendeeCall().createAttendee(param: param) { error, attendee in
                        UserDefaultsHelper.remove(.SELECTED_ATTENDEE)
                        if let error = error, error != "" {
                            print("Create Attendee Faied", error)
                            completion(false)
                        } else {
                            AttendeeService.shared.getAttendeeByUUID { error, attendee in
                                completion(true)
                            }
                        }
                    }
                }
            }
        }
    }
}
