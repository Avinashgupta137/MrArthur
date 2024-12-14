//
//  attendee.restperiodselection.view.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//

import SwiftUI

struct AttendeeRestPeriodSelectionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var observed = AttendeeRestPeriodSelectionObserved()
    @State private var isActiveTimer = false
    @Binding var shouldPopToRootView : Bool
    @Binding var parentSetting : ParentalControlSettingsResponse?
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack{
                    HStack {
                        VStack(alignment: .leading, spacing: 15){
                            Text("Make your choice!".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont25,
                                    color: .primaryBlue
                                )
                            Text("All apps and sites will be blocked during the rest period.".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    VStack(spacing: 47.iPadIncBy_15) {
                        ForEach(observed.getList()) { item in
                            RestPeriodTimerView(
                                contentImage: item.icon,
                                timerLabel: item.label.localized,
                                isActiveTimer: item.isSelected,
                                isBorder: item.isBorder
                            ) {
                                self.observed.selectedRestIndex = item.id
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.observed.setRestPeriod(item: item) {
                                        DispatchQueue.main.async {
                                            self.shouldPopToRootView = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top,20)
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20.iPadIncBy_30)
        .frame(width: UIScreen.screenWidth)
        .onAppear {
            observed.controllSettingResponse = parentSetting
        }
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
        .customNavigationViewWithBackWidgit(title: "Rest period".localized, color: .white)
        .edgesIgnoringSafeArea(.bottom)
    }
}
/*
struct AttendeeRestPeriodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeRestPeriodSelectionView(shouldPopToRootView: .constant(true))
    }
}
*/
