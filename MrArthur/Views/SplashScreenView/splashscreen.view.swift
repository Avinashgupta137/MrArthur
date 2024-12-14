//
//  SplashScreenView.swift
//  MrArthur
//
//  Created by IPS-157 on 06/07/22.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var appState = AppState.shared
    @StateObject private var observed = ObservedSplash()
    @State var isActive : Bool = false
    @State private var size = 1.2
    @State private var iPadFontsize: CGFloat = 11
    @State private var iPhoneFontSize: CGFloat = 6.5
    @State private var opacity = 1.00
    @EnvironmentObject private var attendeeManifestoObservedObject: AttendeeManifestoObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    
    var body: some View {
        Group {
            if (isActive == true){
                switch rootViewObserver.currentPage {
                case .welcome:
                    NavigationStack {
                        OnboardMainView()
                    }
                    .navigationViewStyle(.stack)
                case .observerManifesto:
                    NavigationStack {
                        ObserverManifestoMainView()
                    }
                    .navigationViewStyle(.stack)
                case .returnOBSManifesto:
                    NavigationStack {
                        ObserverManifestoMainView()
                    }
                    .navigationViewStyle(.stack)
                case .signUp:
                    NavigationView {
                        SignUpView()
                    }
                    .navigationViewStyle(.stack)
                case .observerTabBar:
                    ObserverTabBar()
                case .returnOBSTabBar:
                    ObserverTabBar()
                case .observerQuestionPerfectWellDone:
                    NavigationView {
                        QuestionPerfectWellDone()
                    }
                    .navigationViewStyle(.stack)
                case .addAttende:
                    NavigationView {
                        AddAttendeeAccountView()
                    }
                    .navigationViewStyle(.stack)
                case .attendeeManifesto:
                    NavigationView {
                        AttendeeManifesto()
                    }
                    .navigationViewStyle(.stack)
                case .attendeeQuestionPerfectWellDone:
                    NavigationView {
                        AttendeeQuestionPerfectWellDone()
                    }
                    .navigationViewStyle(.stack)
                case .attendeeTabBar:
                    AttendeeTabBar()
                case .returnATTTabBar:
                    AttendeeTabBar()
                case .attendeeDashboard:
                    NavigationView {
                        AttendeeDashboardView()
                    }
                    .navigationViewStyle(.stack)
                case .whichDeviceUsing:
                    NavigationView {
                        WhichDeviceAreYouUsing()
                    }
                    .navigationViewStyle(.stack)
                case .attendeeList:
                    NavigationView {
                        AttendeeListView()
                    }
                    .navigationViewStyle(.stack)
                case .attendeePariningSetup:
                    NavigationView {
                        AttendeePairingSetUpView()
                    }
                    .navigationViewStyle(.stack)
                case .mediationApproved:
                    NavigationView {
                        ObserverHowItWorksLookAtDashboard()
                    }
                    .navigationViewStyle(.stack)
                    
                case .addUpNotificationView:
                    NavigationView {
                        ObserverAddupNotificationView()
                    }
                    .navigationViewStyle(.stack)
                    
                case .attendeeHowItsWorkValidation:
                    NavigationView {
                        AttendeeHowItworkMainView()
                    }
                    .navigationViewStyle(.stack)
                case .gainDataView:
                    NavigationView {
                        ObserverGainDataView()
                    }
                }
            }
            
            else {
                Image("asset_splash_wallpaper".localized)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 147.h)
                    .padding(.bottom, 303.h)
                    .padding(.horizontal, 92.w)
                    .fullScreenFrame
                    .background(Color.secondaryRed)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
//                      rootViewObserver.currentPage = .attendeeTabBar
                    if !AppDetails.getLoginStatus(){
                        if UserDefaultsHelper.latestStep == nil {
                            rootViewObserver.currentPage = .welcome
                        } else {
                            if UserDefaultsHelper.latestStep! >= 24{
                                rootViewObserver.currentPage = .signUp
                            }else{
                                rootViewObserver.currentPage = .observerManifesto
                            }
                        }
                    } else {
                        rootViewObserver.currentPage = UserDefaultsHelper.redirectToScreenOnLaunch
                    }
                }
            }
        }
        .onChange(of: rootViewObserver.currentPage) { newValue in
            UserDefaultsHelper.redirectToScreenOnLaunch = newValue
        }
        .onChange(of: appState.notificationType) { nType in
            switch nType {
            case .INSTALL_ON_CHILD_PHONE_OBSERVER_PUSH:
                NotificationHelper.shared.installAppOnYourChildPhone { root in
                    self.rootViewObserver.currentPage = root
                }
                appState.notificationType = .none
                break
            case .HELP_FOR_SETTINGS_OBSERVER_PUSH:
                NotificationHelper.shared.helpForAttendeeDeviceSetup { root in
                    self.rootViewObserver.currentPage = root
                }
                appState.notificationType = .none
                break
            case .SEND_YOUR_GOAL_OBSERVER_PUSH, .SEND_YOUR_GOAL_ATTENDEE_PUSH:
                let isObserver = nType == .SEND_YOUR_GOAL_OBSERVER_PUSH
                NotificationHelper.shared.attendeeSendYourGoal(isObserver: isObserver) { root in
                    let current = self.rootViewObserver.currentPage
                    print("Current rawvalue : \(current.rawValue)")
                    if isObserver {
                        if current == root, root == .observerTabBar {
                            self.rootViewObserver.currentPage = .returnOBSTabBar
                        }else{
                            self.rootViewObserver.currentPage = root
                        }
                    }else{
                        if current == root, root == .attendeeTabBar {
                            self.rootViewObserver.currentPage = .returnATTTabBar
                        }else{
                            self.rootViewObserver.currentPage = root
                        }
                    }
                    print("self.rootViewObserver.currentPage : \(self.rootViewObserver.currentPage.rawValue)")
                    
                }
                appState.notificationType = .none
                break
            case .GOAL_SENT_OBSERVER_PUSH, .GOAL_SENT_ATTENDEE_PUSH:
                let isObserver = nType == .GOAL_SENT_OBSERVER_PUSH
                NotificationHelper.shared.goalSent(isObserver: isObserver) { root in
                    let current = self.rootViewObserver.currentPage
                    print("Current rawvalue : \(current.rawValue)")
                    if isObserver {
                        if current == root, root == .observerTabBar {
                            self.rootViewObserver.currentPage = .returnOBSTabBar
                        }else{
                            self.rootViewObserver.currentPage = root
                        }
                    }else{
                        if current == root, root == .attendeeTabBar {
                            self.rootViewObserver.currentPage = .returnATTTabBar
                        }else{
                            self.rootViewObserver.currentPage = root
                        }
                    }
                    print("self.rootViewObserver.currentPage : \(self.rootViewObserver.currentPage.rawValue)")
                    
                }
                appState.notificationType = .none
                break
            case .GOAL_REJECTED_OBSERVER_PUSH, .GOAL_REJECTED_ATTENDEE_PUSH:
                let isObserver = nType == .GOAL_REJECTED_OBSERVER_PUSH
                NotificationHelper.shared.goalRejected(isObserver: isObserver) { root in
                    let current = self.rootViewObserver.currentPage
                    print("Current rawvalue : \(current.rawValue)")
                    if isObserver {
                        if current == root, root == .observerTabBar {
                            self.rootViewObserver.currentPage = .returnOBSTabBar
                        }else{
                            self.rootViewObserver.currentPage = root
                        }
                    }else{
                        if current == root, root == .attendeeTabBar {
                            self.rootViewObserver.currentPage = .returnATTTabBar
                        }else{
                            self.rootViewObserver.currentPage = root
                        }
                    }
                    print("self.rootViewObserver.currentPage : \(self.rootViewObserver.currentPage.rawValue)")
                    
                }
                appState.notificationType = .none
                break
            case .none:
                break
            }
        }
    }
}
