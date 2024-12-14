//
//  ObserverMoreMainView.swift
//  MrArthur
//
//  Created by IPS-157 on 04/08/22.
//

import SwiftUI
import WebKit
struct ObserverMoreMainView: View {
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject private var observed = Observed()
    @State var show = false
    @State var showPopup = false
    @State private var showingSheet = false
    @State private var isPresented = false
    @State private var privacyPolicyView = false
    @State private var accountView = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .center){
                VStack(spacing: 0){
                    if observed.canAddChild {
                        Button{
                            AmplitudeService.sendEvent(
                                key: .OBS_PLUS_1_1_ADD_NEW_CHILD
                            )
                            rootViewObserver.currentPage = .addAttende
                        } label: {
                            MoreCardSectionView(
                                buttonImage: "chevron.forward",
                                isSystemImage: true ,
                                buttonTitle: "ADD NEW CHILD".localized
                            )
                        }
                    }
                    Button {
                        AmplitudeService.sendEvent(
                            key: .OBS_PLUS_1_1_PRIVACY_POLICY
                        )
                        self.privacyPolicyView = true
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "chevron.forward",
                            isSystemImage: true ,
                            buttonTitle: "PRIVACY POLICY".localized
                        )
                    }
                    Button {
                        AmplitudeService.sendEvent(
                            key: .OBS_PLUS_1_1_ACCOUNT
                        )
                        self.accountView = true
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "chevron.forward",
                            isSystemImage: true,
                            buttonTitle: "ACCOUNT".localized
                        )
                    }
                    
                    Button {
                        AmplitudeService.sendEvent(
                            key: .OBS_PLUS_1_1_LOGOUT
                        )
                        self.isPresented.toggle()
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "chevron.forward",
                            isSystemImage: true,
                            buttonTitle: "FREQUENT QUESTIONS".localized
                        )
                    }
                    .fullScreenCover(isPresented: $isPresented, content: observerFAQ().scaledToFit)
                    
                    Button {
                        AmplitudeService.sendEvent(
                            key: .OBS_PLUS_1_1_LOGOUT
                        )
                        withAnimation{
                            self.show.toggle()
                        }
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "iconLogOut",
                            buttonTitle: "LOG OUT".localized
                        )
                    }
                    Spacer()
                    
                    NavigationLink(
                        "", destination:
                            PrivacyPolicyView(),
                        isActive: $privacyPolicyView
                    )
                    NavigationLink(
                        "", destination:
                            ObserverAccountDetails(),
                        isActive: $accountView
                    )
                }
                .disabled(self.show)
                .blur(radius: self.show ? 1.2 : 0)
                
                if self.show{
                    CustomAlertPopup(
                        alertHeading: "Do you really want to log out?".localized,
                        leftButtonTitle: "CANCEL".localized,
                        rightButtonTitle: "LOG OUT".localized,
                        action: { actionStatus in
                            if actionStatus{
                                UtilityMethod.logoutObserver {
                                    AmplitudeService.sendEvent(
                                        key: .OBS_PLUS_4_1_LOGOUT_CONFIRM
                                    )
                                    self.rootViewObserver.currentPage = .welcome
                                }
                            }
                            self.show = false
                        }
                    )
                }
                
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 32.h)
            .customNavigationView(
                title: "More".localized,
                color: .navigationBarColor
            )
            .background(
                LinearGradient(
                    colors: [
                        Color.lightPink,
                        Color.secondaryRed
                    ],
                    startPoint: .top,
                    endPoint: .bottomTrailing
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .edgesIgnoringSafeArea(.bottom)
    }
}
