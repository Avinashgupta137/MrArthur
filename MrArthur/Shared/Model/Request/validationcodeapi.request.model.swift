//
//  validationcodeapirequestmodel.swift
//  MrArthur
//
//  Created by IPS-169 on 23/08/22.
//

import Foundation
struct ValidationCodeApiRequestModel:Codable {
    var email: String?
    var code: String?
}
