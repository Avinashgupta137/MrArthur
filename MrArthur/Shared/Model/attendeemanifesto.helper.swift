//
//  MAnifestattendeeHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 01/08/22.
//

import Foundation
class AttendeeManifestoHelper:ObservableObject{
    @Published var onbordingResponseObject = OnbordingResponseModel()
    func nextStepOnBordingAttendeeAPICall(
        stepName:String,
        completion: @escaping (String?, OnbordingResponseModel?) -> ()
    ) {
        let onbordingRequest = OnbordingNextStepRequestModel.init(stepName: stepName)
        if let param = try? onbordingRequest.asDictionary() {
            OnbordingStepAPICall().attendeeOnboardingAPICall(parameter: param, completion: completion)
        }
    }
    
    func fetchAttendeeAnwserList(
        stepName: String,
        anwser: [String],
        completion: @escaping (String?, OnbordingResponseModel?) -> ()
    ) {
        let uuidOfSubscription = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String ?? ""
        
        let attendeeQuestionRequest = ObserverQuestionRequestModel.init(subscriptionUUID: uuidOfSubscription, stepName: stepName, answerList: anwser)
        if let param = try? attendeeQuestionRequest.asDictionary() {
            QuestionListAPICall().attendeeAnsweredAPICall(parameter: param) { error, model in
                DispatchQueue.main.async {
                    completion(error, model)
                }
            }
        }
    }
}
