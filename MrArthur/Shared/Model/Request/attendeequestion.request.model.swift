//
//  questionlistrequestmodel.swift
//  MrArthur
//
//  Created by IPS-169 on 23/08/22.
//

import Foundation
struct AttendeeQuestionRequestModel:Codable {
    var stepName: String?
    var answerList:[String]?
}

struct ObserverQuestionRequestModel:Codable{
    var subscriptionUUID:String?
    var stepName: String?
    var answerList:[String]?
}
