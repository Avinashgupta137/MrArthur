//
//  QuestionDataProcessingView+Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import Foundation
extension QuestionDataProcessingView{
    class QuestionDataProcessingObserver:ObservableObject{
        func onboardingAPICall(completion:@escaping(Bool,String?) -> ()) {
            ManifestoHelper.nextStepOnBordingAPICall(
                stepName: "QUESTION_DATA_PROCESSING"
            ) { error, status in
                completion(status, error)
            }
        }
    }
}
