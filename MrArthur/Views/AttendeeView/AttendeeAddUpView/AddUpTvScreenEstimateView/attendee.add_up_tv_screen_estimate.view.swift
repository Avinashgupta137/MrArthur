//
//  AddUpTvScreenEstimateView.swift
//  MrArthur
//
//  Created by Amit Sinha on 25/07/22.
//

import SwiftUI

struct AddUpTvScreenEstimateView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var estimateMinutes:Int = 0
    @State private var nextButton = false
    //observer object
    @StateObject private var observed = Observed()
    // For Loader
    @EnvironmentObject private var loaderObserver: LoaderObserver
    //For Toast
    @State private var showToast = false
    @State var strToastMessage = ""
    var body: some View {
        VStack(spacing: 0){
            
            TimeEstimateLabelView(text: "How much time per day does your child spend watching television?")
            
            Spacer(minLength: 16.h)
            
            CustomSliderView { minutes in
                estimateMinutes = minutes
            }
            
            Spacer(minLength: 16.h)
            
            InfoLabelView()
            
            Spacer(minLength: 16.h)
            
            BlueRoundedButton("NEXT") {
                var createAttObj = UserDefaultsHelper.createAttendee
                createAttObj?.dailyTVMinutes = estimateMinutes
                UserDefaultsHelper.createAttendee = createAttObj
                AmplitudeService.sendEventWithData(
                    key: .OBS_ADD_UP_ESTIM_1_NEXT,
                    data: ["time_Selected" : estimateMinutes]
                )
                nextButton = true
            }
            
            NavigationLink(
                "",
                destination:  AddUpVideoGamesScreenEstimateView(),
                isActive: $nextButton
            )
        }
        .padding(.vertical, 34.h)
        .toast(
            message: strToastMessage,
            isShowing: $showToast,
            duration: ToastMessage.short
        )
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "Time estimate",
            color: .whiteColor,
            amplitudeEvent: .OBS_ADD_UP_ESTIM_1_BACK
        )
        .background(LinearGradientBackground())
        .edgesIgnoringSafeArea(.all)
    }
}

//struct AddUpTvScreenEstimateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUpTvScreenEstimateView()
//            .multiPreview
//    }
//}
