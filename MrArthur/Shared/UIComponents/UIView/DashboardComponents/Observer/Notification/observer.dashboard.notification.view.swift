//
//  observer.dashboard.notification.view.swift
//  MrArthur
//
//  Created by trootech on 14/09/22.
//

import SwiftUI

struct OBSDashboardNotificationView: View {
    let statusOfMeditation: String
    let notificationViewDate: String
    let previewDate: String
    let onSeeGoal: () -> ()
    let onSeeMore: () -> ()
    var body: some View {
        Group {
            if statusOfMeditation == ConstantOfApp.kMediationUnderApproval {
                OBSDashboardReviewGaolCardView(
                    notificationDate: "\(notificationViewDate)",
                    onSeeGoal: onSeeGoal
                )
            }
            else if statusOfMeditation == ConstantOfApp.kMediationApproved {
                OBSDashboardAcceptedGaolCardView(
                    notificationDate: "\(notificationViewDate)",
                    onSeeMore: onSeeMore
                )
            }
            else if statusOfMeditation == ConstantOfApp.kMediationRejected {
                VStack(spacing: 3.h){
                    OBSDashboardRefusedGaolCardView(
                        notificationDate: "\(notificationViewDate)"
                    )
                    ObserverDashboardPreviousStatusCardView(notificationDate: "\(previewDate)")
                }

            } else {
                OBSReceivedGaolCardView(
                    notificationDate: "\(DateService.shared.getDateMonthYearFromNow())"
                )
            }

        }
    }
}
