//
//  OnbordingRepsponse.swift
//  MrArthur
//
//  Created by IPS-169 on 13/07/22.
//

import Foundation
struct OnbordingResponseModel: Codable ,Identifiable {
    var id :String? =  UUID().uuidString
    var name, type, category, updatedAt: String?
    
}
