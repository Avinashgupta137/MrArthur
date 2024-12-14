//
//  AttendeeMoreView.swift
//  MrArthur
//
//  Created by IPS-157 on 10/08/22.
//

import SwiftUI

struct AttendeeMoreView: View {
    @State private var isPresented = false
    @State var showSeetings = false
    @State var showPrivacyPolicy = false
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing: 0){
                    Button {
                        withAnimation{
                            AmplitudeService.sendEvent(
                                key: .ATT_PLUS_MENU_SETTINGS
                            )
                            self.showSeetings = true
                        }
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "chevron.forward",
                            isSystemImage: true,
                            buttonTitle: "SETTINGS".localized
                        )
                    }
                    
                    Button {
                        withAnimation{
                            AmplitudeService.sendEvent(
                                key: .ATT_PLUS_MENU_PRIVACY_POLICY
                            )
                            showPrivacyPolicy = true
                        }
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "chevron.forward",
                            isSystemImage: true ,
                            buttonTitle: "PRIVACY POLICY".localized
                        )
                    }
                    
                    Button {
                        withAnimation{
                            AmplitudeService.sendEvent(
                                key: .ATT_PLUS_MENU_FREQUENT_QUESTIONS
                            )
                            self.isPresented.toggle()
                        }
                    } label: {
                        MoreCardSectionView(
                            buttonImage: "chevron.forward",
                            isSystemImage: true,
                            buttonTitle: "FREQUENT QUESTIONS".localized
                        )
                    }
                    .fullScreenCover(isPresented: $isPresented, content: observerFAQ().scaledToFit)
                    Spacer()
                }
                
                NavigationLink(
                    "",
                    destination: PrivacyPolicyView(),
                    isActive: $showPrivacyPolicy
                )
                NavigationLink(
                    "",
                    destination: AttendeeSettingsView(shouldPopToRootView: $showSeetings),
                    isActive: $showSeetings
                )
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
        .navigationViewStyle(.stack)
        .edgesIgnoringSafeArea(.bottom)
    }
}
