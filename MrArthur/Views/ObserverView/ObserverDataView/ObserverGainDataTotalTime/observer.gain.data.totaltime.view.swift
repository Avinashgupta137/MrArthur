//
//  observer.gain.data.totaltime.view.swift
//  MrArthur
//
//  Created by IPS-157 on 07/09/22.
//

import SwiftUI
import Macaw
import UIKit
import Purchasely

struct OBSGainDataTotalTimeView: View {
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject private var observer = OBSGainDataTotalTimeViewObserver()
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack{
                    Group{
                        Text("mr.arthur ".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        Text("gives your child his real life back.".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont22,
                                color: .primaryBlue
                            )
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 30.h)
                
                TotalSavedScreenTime(
                    svgName: UtilityMethod.isFrench ? "totalTimeSavedFileFrench" : "totalTimeSavedFile",
                    size: CGSize(width: (UIScreen.screenWidth - 48), height: 450.h),
                    day1TimeValue: observer.day1TimeValue,
                    numberOfAfterNoonRulePerYear : observer.numberOfAfterNoonRulePerYear ,
                    numberOfComicRulePerYear : observer.numberOfComicRulePerYear ,
                    TotalSavedTimePerYear : observer.TotalSavedTimePerYear
                )
                .scaledToFit()
                .padding(24.h)
                .background(Color.white.cornerRadius(32.r))
                .padding(.bottom, 16.h)
                
                HStack{
                    Text("Based on yours answers. With a 20% screen time reduction assumption.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    Spacer()
                }
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton("NEXT") {
                    AmplitudeService.sendEvent(
                        key: .OBS_DATA_GAIN_02_NEXT
                    )
//                    if observer.hasValidSubscription {
//                        gotoNext()
//                    } else {
//                        showPurshaselyService()
//                    }
                    SubscriptionService.paywallHasToBePresented() { hasToBePresented in
                        if (hasToBePresented) {
                            showPurshaselyService()
                        } else {
                            gotoNext()
                        }
                    }
                }.sheet(isPresented: $showingSheet) {
                    PurchaselyPaywall(
                        placementId: PurshaselyService.getOnboardingPlacementId()
                    ) { success in
                        showingSheet = false
                        if (success) { // || isDevelop) {
                            AmplitudeService.sendEvent(
                                key: .OBS_DATA_GAIN_02_NEXT_PAYWALL
                            )
                            gotoNext()
                        } else {
                            SubscriptionService.startBackendTrial() { success in
                                SubscriptionService.paywallHasToBePresented() { hasToBePresented in
                                    if (!hasToBePresented) {
                                        gotoNext()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .labelsHidden()
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 38.h)
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "",
            color: .white,
            amplitudeEvent: .OBS_DATA_GAIN_02_BACK
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func gotoNext() {
        if let currentUser = observer.currentUser {
            if currentUser == ConstantOfApp.kCurrentUserObserver {
                self.rootViewObserver.currentPage = .observerTabBar
            } else {
                self.rootViewObserver.currentPage = .attendeePariningSetup
            }
        } else {
            self.rootViewObserver.currentPage = .whichDeviceUsing
        }
    }
    
    private func showPurshaselyService() {
        PurshaselyService.shared.start() { success in
            if (success) {
                showingSheet = true
            }
        }
    }
}

struct TotalSavedScreenTime: UIViewRepresentable {
    var svgName: String
    let size: CGSize
    var day1TimeValue: Int
    var numberOfAfterNoonRulePerYear: Int
    var numberOfComicRulePerYear: Int
    var TotalSavedTimePerYear: Int
    
    
    func makeUIView(context: Context) -> SVGView {
        if let node = try? SVGParser.parse(resource: svgName){
            let svgView = SVGView(node: node, frame: CGRect(origin: CGPoint.zero, size: size))
            svgView.backgroundColor = UIColor.clear
            return svgView
        }
        return SVGView()
    }
    func updateUIView(_ uiView: SVGView, context: Context) {
        
        if let dayTime = uiView.node.nodeBy(tag: "saved_start_time") as? Macaw.Text{
            dayTime.font = Font(name : Bundle.main.path(forResource: "Montserrat-Bold", ofType: "ttf")!, size : Int(iPhoneFont18), weight : "bold")
            dayTime.text = "\(day1TimeValue) min"
            dayTime.baseline = .alphabetic
            dayTime.place = .init(1, 0, 0, 1, 50, 582)
        }
        if let numberOfBook = uiView.node.nodeBy(tag: "saved_books_time") as? Macaw.Text{
            numberOfBook.font = Font(name : Bundle.main.path(forResource: "Montserrat-Bold", ofType: "ttf")!, size : Int(iPhoneFont18), weight : "bold")
            if UtilityMethod.isFrench {
                numberOfBook.text = "\(numberOfComicRulePerYear) livres"
            }
            else{
                numberOfBook.text = "\(numberOfComicRulePerYear) Books"
            }
            
        }
        if let afterNoonTime = uiView.node.nodeBy(tag: "saved_afternoon_time") as? Macaw.Text{
            afterNoonTime.font = Font(name : Bundle.main.path(forResource: "Montserrat-Bold", ofType: "ttf")!, size : Int(iPhoneFont18), weight : "bold")
            if UtilityMethod.isFrench {
                afterNoonTime.text = "\(numberOfAfterNoonRulePerYear) après-midi"
            } else{
                afterNoonTime.text = "\(numberOfAfterNoonRulePerYear) afternoons"
            }
        }
        if let savedYearTime = uiView.node.nodeBy(tag: "saved_year_time") as? Macaw.Text{
            savedYearTime.font = Font(name : Bundle.main.path(forResource: "Montserrat-Bold", ofType: "ttf")!, size : Int(iPhoneFont18), weight : "bold")
            savedYearTime.text = "\(TotalSavedTimePerYear) h"
            savedYearTime.baseline = .alphabetic
            savedYearTime.place = .init(1, 0, 0, 1, 317, 402)
        }
        
    }
}

/*
struct OBSGainDataTotalTimeView_Previews: PreviewProvider {
    static var previews: some View {
        OBSGainDataTotalTimeView(
            day1TimeValue: .constant(0),
            numberOfAfterNoonRulePerYear: .constant(0),
            numberOfComicRulePerYear: .constant(0),
            TotalSavedTimePerYear: .constant(0),
            iSmartPhoneMinutes: .constant(0),
            iTabletMinutes: .constant(0),
            dailySharedScreenTimeMinutes: .constant(0)
        )
        .multiPreview
    }
}
*/
