//
//  observer.mideation.dashboard.view.swift
//  MrArthur
//
//  Created by BAPS on 09/11/22.
//

import SwiftUI

struct ObserverMideationDashboardView: View {
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    let beforeGoal = "before goal"
    let afterGoal = "after goal"
    @StateObject var observer = ObserverMideationDashboardObserver()
    @ObservedObject var appState = AppState.shared
    @State var attendeeListView = false
    @State var attendeeProfileView = false
    var seprator: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: 1.r)
    }
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing: 0){
                        Button{
                            AmplitudeService.sendEvent(
                                key: .OBS_CO_1_ATTENDEE_LIST
                            )
                            self.attendeeListView = true
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 25.r, weight: .bold))
                                .foregroundColor(Color.primaryBlue)
                        }
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(
                                width: 1.w,
                                height: 34.h
                            )
                            .padding(.horizontal, 16.w)
                        
                        Image(observer.attendee.avtar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 55.r, height: 55.r)
                            .padding(.trailing, 12.5.w)
                        
                        Text(observer.attendee.name?.uppercased() ?? "USERNAME")
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        
                        Spacer(minLength: 16.w)
                        
                        Button {
                            AmplitudeService.sendEvent(
                                key: .OBS_CO_1_ATTENDEE_PROFILE
                            )
                            self.attendeeProfileView = true
                        } label: {
                            Image("iconGear")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40.r, height: 40.r)
                        }
                    }
                    .padding(.bottom, 20.h)
                    
                    OBSDashboardNotificationView(
                        statusOfMeditation: observer.statusOfMeditation,
                        notificationViewDate: observer.createdDateOrUpdatedDateOBD,
                        previewDate: observer.previewUpdatedDate,
                        onSeeGoal: {
                            observer.showGoalSummary = true
                            AmplitudeService.sendEvent(
                                key: .OBS_CO_2_SEE_CHILD_GOAL
                            )
                        },
                        onSeeMore: {
                            
                        }
                    )
                    .padding(.bottom, 35.h)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Usage report".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        
                        seprator
                            .padding(.bottom, 10.h)
                        
                        HStack(spacing: 0){
                            VStack(alignment: .leading, spacing: 0){
                                Text("AVERAGE SCREEN TIME PER DAY".localized)
                                    .fontModifier(
                                        font: .montserratExtraBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                Text((observer.isGoal ? afterGoal : beforeGoal).localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont15,
                                        color: observer.isGoal
                                        ? .validateGreen
                                        : .forthRed
                                    )
                            }
                            
                            Spacer(minLength: 16.h)
                            
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated {
                                Toggle("", isOn: $observer.isGoal)
                                    .labelsHidden()
                                    .toggleStyle(
                                        ColoredToggleStyle(
                                            onColor: .validateGreen,
                                            offColor: .forthRed
                                        )
                                    )
                                    .scaleEffect(1.r)
                            }
                            
                        }
                        .padding(.bottom, 25.5.h)
                        
                        Text(observer.avgScreenTime)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont50
                            )
                            .padding(.vertical, 3.h)
                            .padding(.horizontal, 34.w)
                            .background(
                                (
                                    observer.isGoal ? Color.validateGreen : Color.primaryRed
                                )
                                .cornerRadius(44.r)
                            )
                    }
                    
                    seprator
                        .padding(.top, 42.h)
                        .padding(.bottom, 22.h)
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        
                        HStack(spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("DAILY DEVICES".localized)
                                    .fontModifier(
                                        font: .montserratExtraBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                
                                Text("CONSUMPTION ESTIMATIONS".localized)
                                    .fontModifier(
                                        font: .montserratExtraBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                
                                Text((observer.isGoal ? afterGoal : beforeGoal).localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont15,
                                        color: observer.isGoal
                                        ? .validateGreen
                                        : .forthRed
                                    )
                            }
                            
                            Spacer()
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated {
                                Toggle("", isOn: $observer.isGoal)
                                    .labelsHidden()
                                    .toggleStyle(
                                        ColoredToggleStyle(
                                            onColor: .validateGreen,
                                            offColor: .forthRed
                                        )
                                    )
                                    .scaleEffect(1.r)
                            }
                        }
                        .padding(.bottom, 10.h)
                        
                        HStack(spacing: 16.w) {
                            Text("PUBLIC HEALTH RECOMMENDATIONS".localized)
                                .fontModifier(
                                    font: .montserratExtraBold,
                                    size: iPhoneFont12,
                                    color: .thirdBlue
                                )
                            
                            
                            Text(observer.publicHealthRecommmendationTime.localized)
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont15
                                )
                                .padding(.horizontal, 8.w)
                                .padding(.vertical, 3.h)
                                .background(
                                    Color.thirdBlue
                                        .cornerRadius(24.r)
                                )
                        }
                        .padding(.bottom, 40.h)
                        
                        OBSDashboardUsageGraphView (
                            smartPhoneMinutes: observer.iSmartPhoneMinutes,
                            tabletMinutes:observer.iTabletMinutes,
                            publicHealthRecommendations: observer.iPublicHealthRecommendations,
                            diagnosedScreenTime: observer.graphScreenTime,
                            color: observer.isGoal ? .validateGreen : .primaryRed
                        )
                        .id(observer.fUpdateDailyConsumption)
                        
                    }
                    .padding(.bottom, 20.h)
                    
                    seprator
                        .padding(.bottom, 26.h)
                    
                    
                    LazyVStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("BREAKDOWN OF ACTIVITIES PER DAY".localized)
                                    .fontModifier(
                                        font: .montserratExtraBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                
                                Text((observer.isGoal ? afterGoal : beforeGoal).localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont15,
                                        color: observer.isGoal
                                        ? .validateGreen
                                        : .forthRed
                                    )
                            }
                            
                            Spacer()
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated {
                                Toggle("", isOn: $observer.isGoal)
                                    .labelsHidden()
                                    .toggleStyle(
                                        ColoredToggleStyle(
                                            onColor: .validateGreen,
                                            offColor: .forthRed
                                        )
                                    )
                                    .scaleEffect(1.r)
                            }
                        }
                        .padding(.bottom, 24.h)
                        
                        CircularChartView(
                            totalScreeenTime: observer.iTotalScreenTimeMinutes,
                            educationScreeenTime: observer.iEducationScreeenTime,
                            freeTime: observer.iFreeTime,
                            schoolTime: observer.iSchoolTime
                        )
                        .id(observer.fUpdateBreakActivity)
                        
                    }
                    .padding(.bottom, 16.h)
                    
                    Spacer(minLength: 16.h)
                    
                    Group{
                        NavigationLink(
                            "",
                            destination: ObserverGoalSummaryView(
                                iReducedTotalScreenTimePercent :$observer.miReducedTotalScreenTimePercent,
                                iEducationalTotalScreenTimePercent :$observer.miEducationalTotalScreenTimePercent,
                                sReducedTotalScreenTime :$observer.miReducedTotalScreenTime,
                                sEducationalTotalScreenTime :$observer.miEducationalTotalScreenTime,
                                comic :$observer.miComic,
                                bikeTrip :$observer.miBikeTrip,
                                movies :$observer.miAfternoon,
                                mrArthurImage :$observer.miMrArthurImage,
                                mrArthurMessage :$observer.miMrArthurMessage
                            ),
                            isActive: $observer.showGoalSummary
                        )
                        .labelsHidden()
                        NavigationLink(
                            "",
                            destination: AttendeeListView(fromDashboard: true),
                            isActive: $attendeeListView
                        )
                        .labelsHidden()
                        
                        NavigationLink(
                            "",
                            destination: AttendeeProfileDetailView(),
                            isActive: $attendeeProfileView
                        )
                        .labelsHidden()
                    }
                }
                .onAppear {
                    AmplitudeService.sendEvent(
                        key: .OBS_CO_1_DASHBOARD
                    )
                    observer._init()
                }
                .onReceive(timer) { _ in
                    observer._init()
                }
                .onChange(of: observer.isGoal) { newValue in
                    observer.setScreenTimeData()
                }
                .padding(24.r)
                .frame(width: UIScreen.screenWidth)
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            stops: [
                                Gradient.Stop(color: .secondaryRed, location: 0),
                                Gradient.Stop(color: .lightPink, location: 0.5),
                                Gradient.Stop(color: .secondaryRed, location: 0.9),
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom)
                )
            }
            .customNavigationView(
                title: "Dashboard".localized,
                color: .white
            )
            .onChange(of: appState.notificationType) { notificationType in
                switch notificationType {
                case .SEND_YOUR_GOAL_OBSERVER_PUSH,
                        .GOAL_SENT_OBSERVER_PUSH,
                        .GOAL_REJECTED_OBSERVER_PUSH:
                    UserDefaultsHelper.remove(.SELECTED_ATTENDEE)
                    observer._init()
                    break
                default:
                    break
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
/*
struct ObserverMideationDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ObserverMideationDashboardView()
        .multiPreview
    }
}*/
