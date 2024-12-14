//
//  ErrorResponse.swift
//  MrArthur
//
//  Created by IPS-169 on 14/07/22.
//

import Foundation
struct ErrorResponseModel: Codable,Identifiable{
    var id :String? =  UUID().uuidString
    var message:[String]?
    var error: String?
    var statusCode:Int?
}
