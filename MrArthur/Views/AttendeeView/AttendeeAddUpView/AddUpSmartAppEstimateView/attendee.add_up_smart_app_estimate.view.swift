//
//  AddUpSmartAppEstimateView.swift
//  MrArthur
//
//  Created by Amit Sinha on 25/07/22.
//

import SwiftUI

struct AddUpSmartAppEstimateView: View {
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject private var observer = AddUpSmartAppEstimateObserver()
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @State var estimateMinutes:Int = 0
    @State private var buttonShow = false
    @State private var dataGainIsActive = false
    //For Toast
    @State private var showToast = false
    @State var strToastMessage = ""
    
    var body: some View {
        LoadingView{
            VStack(spacing: 0){
                TimeEstimateLabelView(
                    text: "How much time per day does your child spend on educational apps?"
                )
                
                Spacer(minLength: 16.h)
                
                CustomSliderView { minutes in
                    estimateMinutes = minutes
                }
                
                Spacer(minLength: 16.h)
                
                InfoLabelView()
                    .opacity(0)
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton("NEXT") {
                    AmplitudeService.sendEventWithData(
                        key: .OBS_ADD_UP_ESTIM_6_NEXT,
                        data: ["time_Selected" : estimateMinutes]
                    )
                    var createAttObj = UserDefaultsHelper.createAttendee
                    createAttObj?.dailyEducativeTimeMinutes = estimateMinutes
                    UserDefaultsHelper.createAttendee = createAttObj
                    self.loaderObserver.showLoader = true
                    observer.addAttendee { status in
                        self.loaderObserver.showLoader = false
                        self.rootViewObserver.currentPage = .gainDataView
                    }
                }
            }
        }
        .padding(.vertical, 34.h)
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "Time estimate".localized,
            color: .whiteColor,
            amplitudeEvent: .OBS_ADD_UP_ESTIM_6_BACK
        )
        .background(LinearGradientBackground())
        .edgesIgnoringSafeArea(.all)
    }
}

//struct AddUpSmartAppEstimateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUpSmartAppEstimateView()
//            .multiPreview
//    }
//}
