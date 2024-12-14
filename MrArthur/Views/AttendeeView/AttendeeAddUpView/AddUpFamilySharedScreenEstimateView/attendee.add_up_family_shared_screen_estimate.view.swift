//
//  AddUpFamilySharedScreenEstimateView.swift
//  MrArthur
//
//  Created by Amit Sinha on 25/07/22.
//

import SwiftUI

struct AddUpFamilySharedScreenEstimateView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var timeSelected: String = "0h"
    @State var estimateMinutes:Int = 0
    @State private var nextButton = false
    @State private var buttonShow = false
    //observer object
    @StateObject private var observed = Observed()
    //For Toast
    @State private var showToast = false
    @State var strToastMessage = ""
    var body: some View {
        VStack(spacing: 0){
            
            TimeEstimateLabelView(text: "How much does your child spend on shared screens (Household television, tablet, computer, etc.)?")
            
            Spacer(minLength: 16.h)
            
            CustomSliderView { minutes in
                estimateMinutes = minutes
                timeSelected = "\(estimateMinutes)"
            }
            
            Spacer(minLength: 16.h)
            
            InfoLabelView()
            
            Spacer(minLength: 16.h)
            
            BlueRoundedButton("NEXT") {
                var createAttObj = UserDefaultsHelper.createAttendee
                createAttObj?.dailySharedScreenTimeMinutes = estimateMinutes
                UserDefaultsHelper.createAttendee = createAttObj
                AmplitudeService.sendEventWithData(
                    key: .OBS_ADD_UP_ESTIM_3_NEXT,
                    data: ["time_Selected" : estimateMinutes]
                )
                nextButton = true
            }
            
            NavigationLink(
                "",
                destination:  AddUpSmartPhoneScreenEstimateView(),
                isActive: $nextButton
            )
        }
        .padding(.vertical, 34.h)
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "Time estimate".localized,
            color: .whiteColor,
            amplitudeEvent: .OBS_ADD_UP_ESTIM_3_BACK
        )
        .background(LinearGradientBackground())
        .edgesIgnoringSafeArea(.all)
    }
}

//struct AddUpFamilySharedScreenEstimateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUpFamilySharedScreenEstimateView()
//            .multiPreview
//    }
//}
