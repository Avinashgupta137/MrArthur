//
//  FinalGoalScreenView.swift
//  MrArthur
//
//  Created by IPS-157 on 10/08/22.
//

import SwiftUI

struct FinalGoalScreenView: View {
    @StateObject private var finalGoalObserved = FinalGoalObserved()
    let reducedScreenTimePercentage: Int
    let increasedEducationTimePercentage: Int
    let increasedEducationTime: String
    let reducedScreenTime: String
    @Binding var shouldPopToRootView : Bool
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    
    var body: some View {
        LoadingView {
            VStack(alignment: isiPad() ? .center : .leading, spacing: 0) {
                
                ATTGoalSummaryTextView(
                    rPercentage: reducedScreenTimePercentage,
                    rDuration: reducedScreenTime,
                    ePercentage: increasedEducationTimePercentage,
                    eDuration: increasedEducationTime
                    
                )
                
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .fill(Color.whiteColor)
                            .frame(height: 1.h)
                        
                        Image(finalGoalObserved.mrArthurImage)
                            .resizable()
                            .frame(width: 110.r, height: 110.r)
                    }
                    
                    Text(finalGoalObserved.mrArthurMessage)
                        .fontModifier(
                            font: .montserratBoldItalic,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 24.h)
                    
                    Spacer(minLength: 16.h)
                    
                    BlueRoundedButton("SEND") {
                        loaderObserver.showLoader = true
                        finalGoalObserved.submitGoal(
                            reducedScreenTimePercentage: reducedScreenTimePercentage,
                            increasedEducationTimePercentage: increasedEducationTimePercentage,
                            reducedScreenTime: reducedScreenTime,
                            increasedEducationTime: increasedEducationTime) { errorr in
                                loaderObserver.showLoader = false
                                if let error = errorr, !error.isEmpty {
                                    print("finalGoalObserved.submitGoal \(error)")
                                } else {
                                    rootViewObserver.currentPage = .attendeeTabBar
                                }
                            }
                    }
                }
            }
        }
        .padding(.vertical, 34.h)
        .padding(.horizontal, 24.w)
        .hideNavigation
        .statusBarStyle(color: .statusBarColor)
        .background(
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        Gradient.Stop(
                            color: .lightPink, location: 0.5
                        ),
                        Gradient.Stop(
                            color: .secondaryRed, location: 0.9
                        ),
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            finalGoalObserved._init(
                reducedPercentage: reducedScreenTimePercentage,
                educationIncPercent: increasedEducationTimePercentage
            )
        }
    }
}

struct FinalGoalScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FinalGoalScreenView(
            reducedScreenTimePercentage: 23,
            increasedEducationTimePercentage: 21,
            increasedEducationTime: "00h00",
            reducedScreenTime: "00h00",
            shouldPopToRootView: .constant(false)
        )
        .multiPreview
    }
}


