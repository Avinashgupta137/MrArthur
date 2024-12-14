//
//  AttendeeQuestionDataProcessing+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 03/08/22.
//

import Foundation
extension AttendeeQuestionDataProcessing{
   
    class AttendeeQuestionDataProcessingObserver: ObservableObject{
        func nextStepOnBordingAttendeeAPICall(
            completion: @escaping(String?, OnbordingResponseModel?) -> ()
        ) {
            let onbordingRequest = OnbordingNextStepRequestModel.init(stepName: "QUESTION_DATA_PROCESSING")
            if let  param = try? onbordingRequest.asDictionary() {
                
                OnbordingStepAPICall().attendeeOnboardingAPICall(parameter: param) { error, model in
                    DispatchQueue.main.async {
                        completion(error, model)
                    }
                }
            } else {
                completion(nil, nil)
            }
        }
        
    }
}
