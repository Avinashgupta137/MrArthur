//
//  CreateAttendeeResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 25/07/22.
//

import Foundation
struct CreateAttendeeResponseModel: Codable ,Identifiable {
    var id : String {
        return attendeeUserUUID ?? ""
    }
    var attendeeUserMediationUUID, attendeeUserOnboardingUUID, attendeeUserUUID: String?
    
}
