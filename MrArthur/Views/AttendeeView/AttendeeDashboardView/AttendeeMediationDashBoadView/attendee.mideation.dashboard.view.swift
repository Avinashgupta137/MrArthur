//
//  attendee.mideation.dashboard.view.swift
//  MrArthur
//
//  Created by Troo on 01/08/22.
//

import SwiftUI

struct AttendeeMideationDashboardView: View {
    @Environment(\.scenePhase) var scenePhase
    @Binding var manifestoCompleted: Bool
    @StateObject var observer = AttendeeMideationDashboardObserver()
    @ObservedObject var appState = AppState.shared
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    let beforeGoal = "before goal".localized
    let afterGoal = "after goal".localized
    var seprator: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: 1.h)
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.h) {
                    HStack(spacing: 10.w){
                        Image(observer.attendee.avtar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 55.r, height: 55.r)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Hello,".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            Text(observer.attendee.name?.uppercased() ?? "USERNAME")
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        Spacer()
                    }
                    .padding(.bottom, 20.h)
                    Group {
                        if observer.statusOfMeditation == ConstantOfApp.kMediationNotCreated{
                            AttendeeDashboardCreateMyGoalCardView(
                                notificationDate: "\(DateService.shared.getDateMonthYearFromNow())",
                                action: {
                                    observer.createGoal = true
                                }
                            )
                        } else if observer.statusOfMeditation == ConstantOfApp.kMediationUnderApproval{
                            VStack(spacing: 3.h){
                                AttendeeDashboardSeeMyGoalCardView(
                                    notificationDate: "\(observer.createdDateOrUpdatedDate)",
                                    action: {
                                        observer.goalSummary = true
                                    }
                                )
                                AttendeeDashboardPreviousStatusCardView(
                                    notificationDate : (observer.previewDateOrUpdatedDate),
                                    cardTitle : "You have 24 hours to provide",
                                    cardMessage :"your parents with a goal."
                                )
                            }
                        } else if observer.statusOfMeditation == ConstantOfApp.kMediationApproved{
                            AttendeeDashboardLetsGetStartedCardView(
                                notificationDate: "\(observer.createdDateOrUpdatedDate)"
                            )
                        }
                        else if observer.statusOfMeditation == ConstantOfApp.kMediationRejected{
                            VStack(spacing: 3.h){
                                AttendeeDashboardICanDoBetterCardView(
                                    notificationDate: "\(observer.createdDateOrUpdatedDate)"
                                )
                                AttendeeDashboardPreviousStatusCardView(
                                    notificationDate : "\(observer.createdDateOrUpdatedDate)",
                                    cardTitle : "Congratulations!",
                                    cardMessage :"You’ve just sent your parents your first goal. It’s time for them to review your proposal. They’ll send you their answer here!"
                                )
                            }
                            
                        } else {
                            AttendeeDashboardCreateMyGoalCardView(
                                notificationDate: "\(DateService.shared.getDateMonthYearFromNow())",
                                action: {
                                    AmplitudeService.sendEvent(key: .ATT_CO_1_CREATE_GOAL)
                                    observer.createGoal = true
                                }
                            )
                        }
                    }
                    .padding(.bottom, 30.h)
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
                                        font: .montserratBold,
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
                            Spacer(minLength: 16.w)
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated{
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
                        .padding(.bottom, 20.h)
                        
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
                        .padding(.bottom, 10.h)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(spacing: 0){
                            VStack(alignment: .leading, spacing: 0){
                                Text("WHAT YOU GET OUT OF THIS".localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                Text(
                                    observer.isGoal
                                    ? afterGoal.localized
                                    : beforeGoal.localized
                                )
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont15,
                                    color: observer.isGoal
                                    ? .validateGreen
                                    : .forthRed
                                )
                            }
                            Spacer()
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated{
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
                        .padding(.bottom, 25.5.resizable)
                        HStack(spacing: 5) {
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoBook",
                                title: observer.titleComic,
                                subTitle: "per year".localized
                            )
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoBike",
                                title: observer.titleRide,
                                subTitle: "bike trips".localized
                            )
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoFriendsMovie",
                                title: observer.titleAfternoon,
                                subTitle: "with friends".localized
                            )
                        }
                        Spacer()
                    }
                    
                    seprator
                        .padding(.top, 14.h)
                        .padding(.bottom, 22.h)
                    
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        
                        HStack(spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("DAILY DEVICES".localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                
                                Text("CONSUMPTION ESTIMATIONS".localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                
                                Text(
                                    observer.isGoal
                                    ? afterGoal.localized
                                    : beforeGoal.localized
                                )
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont15,
                                    color: observer.isGoal
                                    ? .validateGreen
                                    : .forthRed
                                )
                            }
                            
                            Spacer()
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated{
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
                        .padding(.bottom, 8.h)
                        
                        HStack(spacing: 8.w) {
                            Text("PUBLIC HEALTH RECOMMENDATIONS".localized)
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont12,
                                    color: Color.thirdBlue
                                )
                            Spacer()
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
                        .padding(.bottom, 38.h)
                        
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
                    .padding(.top, 26.h)
                    
                    seprator
                        .padding(.bottom, 26.h)
                    
                    LazyVStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("BREAKDOWN OF ACTIVITIES PER DAY".localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: 15,
                                        color: .primaryBlue
                                    )
                                Text(
                                    observer.isGoal
                                    ? afterGoal.localized
                                    : beforeGoal.localized
                                )
                                .fontModifier(
                                    font: .montserratBold,
                                    size: 15,
                                    color: observer.isGoal
                                    ? .validateGreen
                                    : .forthRed
                                )
                            }
                            Spacer()
                            if observer.statusOfMeditation != ConstantOfApp.kMediationNotCreated{
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
                        .padding(.bottom, 25.h)
                        
                        CircularChartView(
                            totalScreeenTime: observer.iTotalScreenTimeMinutes,
                            educationScreeenTime: observer.iEducationScreeenTime,
                            freeTime: observer.iFreeTime,
                            schoolTime: observer.iSchoolTime
                        )
                        .id(observer.fUpdateBreakActivity)
                        
                        Spacer(minLength: 16.h)
                    }
                    .padding(.bottom, observer.statusOfMeditation == ConstantOfApp.kMediationNotCreated ? 110.h : 32.h)
                }
                
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        print("Active")
                    } else if newPhase == .inactive {
                        print("Inactive")
                    } else if newPhase == .background {
                        print("Background")
                    }
                }
                .onChange(of: observer.isGoal) { newValue in
                    observer.setScreenTimeData()
                }
                .onReceive(timer) { _ in
                    print("Timer call to update view")
                    self.loadData()
                }
                
                .padding(24.r)
                .frame(width: UIScreen.screenWidth)
                .onAppear {
                    self.loadData()
                    print("ON === = = APPEAR")
                }
                
            }
            .padding(.top, 5.h)
            .zIndex(0)
            
            if observer.statusOfMeditation == ConstantOfApp.kMediationNotCreated {
                Button {
                    AmplitudeService.sendEvent(
                        key: .ATT_CO_1_CREATE_GOAL
                    )
                    observer.createGoal = true
                } label: {
                    Text("CREATE MY GOAL".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont15
                        )
                        .frame(
                            width: 208.w,
                            height: 60.h
                        )
                        .background(
                            Color.primaryBlue
                                .cornerRadius(50)
                        )
                }
                .contentShape(Rectangle())
                .zIndex(1)
                .padding(.bottom, 95.h)
            }
            
            NavigationLink(
                "",
                destination: AttendeeCreateGoalView(
                    rootIsActive: $observer.createGoal
                ),
                isActive: $observer.createGoal
            )
            .isDetailLink(false)
            
            NavigationLink(
                "",
                destination: AttendeeGoalSummary(
                    iReducedTotalScreenTimePercent: $observer.miReducedTotalScreenTimePercent,
                    iEducationalTotalScreenTimePercent: $observer.miEducationalTotalScreenTimePercent,
                    sReducedTotalScreenTime: $observer.miReducedTotalScreenTime,
                    sEducationalTotalScreenTime: $observer.miEducationalTotalScreenTime
                ),
                isActive: $observer.goalSummary
            )
        }
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
        .hideNavigation
        .statusBarStyle(color: .statusBarColor)
        .edgesIgnoringSafeArea(.bottom)
        .onChange(of: appState.notificationType) { notificationType in
            switch notificationType {
            case .SEND_YOUR_GOAL_ATTENDEE_PUSH,
                    .GOAL_SENT_ATTENDEE_PUSH,
                    .GOAL_REJECTED_ATTENDEE_PUSH:
                UserDefaultsHelper.remove(.SELECTED_ATTENDEE)
                self.loadData()
                break
            default:
                break
            }
        }
    }
    
    private func loadData() {
        observer._init { status in
            self.manifestoCompleted = status
        }
    }
}

/*
struct AttendeeMideationDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeMideationDashboardView(manifestoCompleted: .constant(false))
            .multiPreview
    }
}*/
