//
//  ManifestoHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 25/07/22.
//

import Foundation

class ManifestoHelper {
    
    static func nextStepOnBordingAPICall(
        stepName: String,
        completion: @escaping(String?, Bool) -> ()
    ) {
        let request = OnbordingNextStepRequest(subscriptionUUID: UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String ?? "", stepName: stepName)
        OnbordingStepAPICall()
            .apiCall(parameter: request) { errorMsg, data in
                DispatchQueue.main.async {
                    if let error = errorMsg, !error.isEmpty {
                        completion(error, false)
                    } else {
                        completion(nil, true)
                    }
                }
            }
    }
    
    static func fetchAnwserList(
        stepName:String,
        anwser:[String],
        completion:@escaping(String?, Bool) -> ()
    ) {
        let uuidOfSubscription = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String ?? ""
        let questionRequestModel = ObserverQuestionRequestModel.init(
            subscriptionUUID: uuidOfSubscription, 
            stepName: stepName, 
            answerList: anwser
        )
        
        if let param = try? questionRequestModel.asDictionary() {
            QuestionListAPICall().request(parameter: param) { errorMsg, data in
                DispatchQueue.main.async {
//                    if(errorMsg?.count == 0){
//                        completion("", true)
//                    } else {
//                        completion(errorMsg ?? ConstantOfApp.kErrorDefaultMessage, false)
//                    }
                    if let error = errorMsg, !error.isEmpty {
                        completion(error, false)
                    } else {
                        completion(nil, true)
                    }
                }
            }
        }
    }
}
