//
//  observer.dashboard.benefit.view.swift
//  MrArthur
//
//  Created by Troo on 30/08/22.
//

import SwiftUI

struct ObserverDashboardBenefitView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                EducationalProfitView()
                FamilyTimeSavedView()
            }
        }
    }
}

private struct EducationalProfitView: View {
    @State var showEducatioanlCard = false
    var body: some View {
        VStack{
            Button{
                AmplitudeService.sendEvent(
                    key: .OBS_DASH_TIME_01_START_EDUCATIONAL_PROFIT
                )
                self.showEducatioanlCard = true
            } label: {
                VStack(alignment: .trailing, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("EDUCATIONAL\nPROFIT".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 16.w)
                        Image(systemName: "chevron.forward")
                            .renderingMode(.template)
                            .font(
                                .system(
                                    size: 22.r,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundColor(.primaryBlue)
                    }
                    Spacer(minLength: 16.w)
                    Image("DasboardCollectableBrain")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130.w, height: 75.h, alignment: .trailing)
                    
                }
            }
            NavigationLink(
                "",
                destination: ObserverEducationalBenefitDetailsView(),
                isActive: $showEducatioanlCard
            )
            .labelsHidden()
        }
        .padding(.vertical, 12.h)
        .padding(.horizontal, 16.h)
        .background(Color.white.cornerRadius(22.r))
    }
}

private struct FamilyTimeSavedView: View {
    @State var showTimesavedCard = false
    var body: some View {
        VStack{
            Button{
                AmplitudeService.sendEvent(
                    key: .OBS_DASH_TIME_01_START_TIME_SAVED_FROM_SCREENS
                )
                self.showTimesavedCard = true
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("FAMILY TIME\nSAVED".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 16.w)
                        Image(systemName: "chevron.forward")
                            .renderingMode(.template)
                            .font(
                                .system(
                                    size: 22,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundColor(.primaryBlue)
                    }
                    Spacer(minLength: 16.w)
                    Image("DashboardCollectableSwing")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160.w, height: 75.h)
                    
                }
            }
            NavigationLink(
                "",
                destination: ObserverTimeSavedScreenBenefitView(),
                isActive: $showTimesavedCard
            )
            .labelsHidden()
            
        }
        .padding(.vertical, 12.h)
        .padding(.horizontal, 16.h)
        .background(Color.white.cornerRadius(22.r))
    }
}

private struct PersonnalProfitView: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            HStack(spacing: 25) {
                Text("PERSONNAL\nPROFIT".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                Image(systemName: "chevron.forward")
                    .font(
                        .system(
                            size: 22,
                            weight: .bold,
                            design: .rounded
                        )
                    )
            }
            
            Image("DashboardCollectableFlower")
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 75, alignment: .trailing)
            
        }
        .padding(.vertical, 12.h)
        .padding(.horizontal, 16.h)
        .background(Color.white.cornerRadius(22.r))
    }
}

/*
struct ObserverDashboardBenefitViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ObserverDashboardBenefitView()
            Spacer()
        }
        .fullScreenFrame
        .background(Color.secondaryRed)
        .multiPreview
    }
}*/
