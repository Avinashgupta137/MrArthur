//
//  parentgoalsummary.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 25/08/22.
//

import Foundation
import WebKit
import SwiftUI

extension ObserverGoalSummaryView{
    class ObserverGoalSummaryObserver:ObservableObject {

        func getHtmlString(
            rPercentage: Int,
            rDuration: String,
            ePercentage: Int,
            eDuration: String
        ) -> String {
            return """
            <p>\("Reduce ".localized)<br>
                <span class="primaryRedBg">\("overall screen time".localized)</span>
                 \(" by".localized)
                <span style="color: #FD657C;">\(rPercentage)%</span>
                \("or ".localized)
                <span class="primaryRedBg">\(rDuration)</span>
                \(" per day".localized)
            </p>
            <p>
                \("Increase ".localized)<br>
                <span class="primaryBlueBg">\("educational screen time".localized)</span>
                 \("by ".localized)
                <span style="color: #272F60;">\(ePercentage)%</span>
                \("or ".localized)
                <span class="primaryBlueBg">\(eDuration)</span>
                \(" per day".localized)
            </p>
"""
        }
        
        func approveMediation(
            status : Bool,
            completion:@escaping (Bool,String,MediationApprovalResponseModel)->()
        ) {
            ApproveMediationAPICall().approveMediationInfo(acceptStatus: status) { status, message,response in
                print(response)
                completion(status,message,response)
            }
        }
    }
}
