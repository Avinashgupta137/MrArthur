//
//  AttendeeProfileInformationView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 05/08/22.
//

import Foundation
import SwiftUI

extension AttendeeProfileInformationView{
    class AttendeeProfileInformationObserver: ObservableObject {
        
        @Published var isPickerVisible = false
        @Published var showPicker = false
        @Published var attendeeName : String = UserDefaultsHelper.selectedAttendee?.attendeeName ?? ""
        @Published var editUsername = false
        @Published var date = Date.now.addingTimeInterval(-86400)
        @Published var isAPICall = false
        @Published var attendeeAvtar = "iconAvatarProfileBoy"
        
        let attendeeGender = UserDefaultsHelper.selectedAttendee?.gender ?? ""
        
        let dateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
            let start = calendar.date(
                byAdding: .year,
                value: -30,
                to: Date.now
            ) ?? Date.now
            let end = calendar.date(
                byAdding: .day,
                value: -1,
                to: Date.now
            ) ?? Date.now
            return start...end
        }()
        
        func _init(){
            attendeeAvtar = attendeeGender.uppercased() == "MALE" ? "iconAvatarProfileBoy" : "iconAvatarProfileGirl"
            attendeeName = UserDefaultsHelper.selectedAttendee?.attendeeName ?? ""
            date = UserDefaultsHelper.selectedAttendee?.attendeeDOB ?? Date.now.addingTimeInterval(-86400)
        }
        
        func editAttendeeAPI(completion: @escaping () -> ()) {
            let birthDate = date.getFormattedDate(format: "yyyy-MM-dd")
            let request =  EditAttendeeRequesModel(
                attendeeName: attendeeName,
                gender: attendeeGender,
                birthDate: "\(birthDate)")
            EditAttendeeAPICall().editAttendee(parameter: try? request.asDictionary()) { message, status, editProfileResponseModel  in
                if status {
                    self.isAPICall = true
                    UserDefaultsHelper.remove(.SELECTED_ATTENDEE)
                    AttendeeService.shared.getAttendeeByUUID { error, attendee in
                        if let attendee = attendee {
                            UserDefaultsHelper.selectedAttendee = attendee
                            completion()
                        }
                    }
                } else {
                    print("\(message)")
                }
            }
        }
    }
}
