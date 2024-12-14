//
//  FinalGoalScreenView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 10/08/22.
//

import Foundation
import SwiftUI
extension FinalGoalScreenView {
    class FinalGoalObserved: ObservableObject {
        
        @Published var mrArthurImage = GoalDetailService.initImage
        @Published var mrArthurMessage = GoalDetailService.initMessage
        
        func _init(
            reducedPercentage: Int,
            educationIncPercent: Int
        ) {
            let (label, image) = GoalDetailService.getTextImageForWorst(
                reducedPercentage: reducedPercentage,
                educationIncPercent: educationIncPercent,
                forChild: true
            )
            self.mrArthurImage = image
            self.mrArthurMessage = label
        }
        
        func submitGoal(
            reducedScreenTimePercentage: Int,
            increasedEducationTimePercentage: Int,
            reducedScreenTime: String,
            increasedEducationTime: String,
            complition: @escaping (String?) -> ()
        ) {
            let addstepmediationrequest = AddStepMediationRequestModel(
                totalTimeReductionPercent: reducedScreenTimePercentage,
                educativeTimePercent: increasedEducationTimePercentage
            )
            if let param = try? addstepmediationrequest.asDictionary(){
                AddMediationStepAPICall().addStep(param: param) { errormsg, addstepresponse in
                    if let error = errormsg, !error.isEmpty {
                        complition(error)
                    } else {
                        UtilityMethod().setData(
                            value: ConstantOfApp.kMediationUnderApproval,
                            key: ConstantOfApp.kStatusOfMeditation
                        )
                        complition(nil)
                    }
                }
            }
        }
    }
}
