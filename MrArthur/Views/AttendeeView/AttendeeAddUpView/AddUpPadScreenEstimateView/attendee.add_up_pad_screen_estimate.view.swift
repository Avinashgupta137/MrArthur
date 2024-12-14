//
//  AddUpPadScreenEstimateView.swift
//  MrArthur
//
//  Created by Amit Sinha on 25/07/22.
//

import SwiftUI

struct AddUpPadScreenEstimateView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var nextButton = false
    @State var estimateMinutes:Int = 0
    @State private var buttonShow = false
    //observer object
    @StateObject private var observed = Observed()
    //For Toast
    @State private var showToast = false
    @State var strToastMessage = ""
    var body: some View {
        VStack(spacing: 0){
            
            TimeEstimateLabelView(
                text: "How much time per day does your child spend on his own tablet?"
            )
            Spacer(minLength: 16.h)
            CustomSliderView { minutes in
                estimateMinutes = minutes
            }
            Spacer(minLength: 16.h)
            InfoLabelView()
            Spacer(minLength: 16.h)
            BlueRoundedButton("NEXT") {
                var createAttObj = UserDefaultsHelper.createAttendee
                createAttObj?.dailyOwnTabletMinutes = estimateMinutes
                UserDefaultsHelper.createAttendee = createAttObj
                nextButton = true
                AmplitudeService.sendEventWithData(
                    key: .OBS_ADD_UP_ESTIM_5_NEXT,
                    data: ["time_Selected" : estimateMinutes]
                )
            }
            
            NavigationLink(
                "",
                destination:  AddUpSmartAppEstimateView(),
                isActive: $nextButton
            )
        }
        .padding(.vertical, 34.h)
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "Time estimate".localized,
            color: .whiteColor,
            amplitudeEvent: .OBS_ADD_UP_ESTIM_5_BACK
        )
        .background(LinearGradientBackground())
        .edgesIgnoringSafeArea(.all)
    }
}

//struct AddUpPadScreenEstimateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUpPadScreenEstimateView()
//            .multiPreview
//    }
//}
