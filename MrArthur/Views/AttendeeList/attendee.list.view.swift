//
//  attendee.list.view.swift
//  MrArthur
//
//  Created by IPS-169 on 06/09/22.
//

import SwiftUI

struct AttendeeListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var attendeeListObserverableObj = Observed()
    @EnvironmentObject private var loaderObserver: LoaderObserver
    var fromDashboard: Bool = false
    @State var dashboard = false
    @State var tabbar = false
    @State var createAttendee = false
    var userExistingOrNew = UtilityMethod().getValueForKey(key: ConstantOfApp.kIsUserNewOrExist) as? String ?? ""
    @EnvironmentObject private var rootViewObserver : RootViewObserver
    var currentUserRole = UtilityMethod().getValueForKey(key: ConstantOfApp.kCurrentUserRole) as? String
    
    var body: some View {
        LoadingView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                    if(userExistingOrNew == ConstantOfApp.kExistingUser  && fromDashboard){
                        VStack(alignment: .leading, spacing: 25.h){
                            
                            Text("Child device assignment".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont22,
                                    color: .primaryBlue
                                )
                            Text("Select the child you want this device to be assigned, or create a new one.".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        .padding(.bottom, 16.h)
                    }
                    
                    if attendeeListObserverableObj.arrOfAttendee.count > 0 {
                        
                        VStack(spacing: 16.h) {
                            ForEach(
                                0..<attendeeListObserverableObj.arrOfAttendee.count,
                                id: \.self) { i in
                                    let attendee = attendeeListObserverableObj.arrOfAttendee[i]
                                    AttendeeListCellView(
                                        title: attendee.name ?? "NA" ,
                                        iconAvtar: attendee.isMale
                                        ? "iconAvatarProfileBoy"
                                        : "iconAvatarProfileGirl",
                                        isSystemImage: false
                                    ) {
                                        AmplitudeService.sendEventWithData(
                                            key: .OBS_SIGN_IN_USER_CHOICE_2_ATTENDEE,
                                            data: ["attendeeName" : attendee.name ?? "NA"]
                                        )
                                        self.onChilsSelection(attendee: attendee)
                                    }
                                }
                        }
                        .padding(.bottom, 16.h)
                    }
                    
                    if attendeeListObserverableObj.arrOfAttendee.count < 5 {
                        AttendeeListCellView(
                            title: "Add\nNEW CHILD".localized,
                            iconAvtar: "plus",
                            isSystemImage: true
                        ) {
                            AmplitudeService.sendEvent(
                                key: .OBS_SIGN_IN_USER_CHOICE_2_ADD_NEW_CHILD
                            )
                            rootViewObserver.currentPage = .addAttende
                        }
                    }
                    
                    NavigationLink(
                        "", destination:
                            AttendeeDashboardView(),
                        isActive: $dashboard
                    )
                    
                    NavigationLink(
                        "", destination:
                            AttendeeTabBar(),
                        isActive: $tabbar
                    )
                    
                    NavigationLink(
                        "", destination:
                            AddAttendeeAccountView(),
                        isActive: $createAttendee
                    )
                    
                }
            }
        }
        .padding(.horizontal, 24.h)
        .padding(.vertical, 34.h)
        .customNavigationViewWithBackWidgit(
            title: "Users".localized,
            color: .white,
            showBackButton: fromDashboard
        )
        .hideNavigation
        .statusBarStyle(color: .white)
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
    }
    
    private func onChilsSelection(attendee: AttendeeListResponseModel) {
        AppState.shared.attendeeMediationCompleted = attendee.mediationCompleted
        AppState.shared.attendeeMediationCompletedOBS = UserDefaultsHelper.getAttendeeScreenTimeFlag(uuid: attendee.uuid)
        UserDefaultsHelper.selectedAttendee = attendee
        UtilityMethod().setData(
            value: attendee.uuid,
            key: ConstantOfApp.kAttendeeUUID
        )
        UtilityMethod().setData(
            value: attendee.attendeeUserMediationList?.first?.uuid,
            key: ConstantOfApp.kMediationUDID
        )
        if currentUserRole != nil {
            if(currentUserRole == ConstantOfApp.kCurrentUserObserver){
                let mediation = attendee.attendeeUserMediationList?.first
                UtilityMethod()
                    .saveInDefault(
                        value: mediation?.uuid ?? "",
                        key: ConstantOfApp.kMediationUDID
                    )
                
                UtilityMethod()
                    .saveInDefault(
                        value: attendee.uuid ?? "nouuid",
                        key: ConstantOfApp.kAttendeeUUID
                    )
                if fromDashboard {
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.rootViewObserver.currentPage = .observerTabBar
                }
                
            } else {
                let settingDone =  UtilityMethod().getValueForKey(key: ConstantOfApp.kAppSettingDone) as? Bool ?? false
                if(settingDone){
                    loaderObserver.showLoader = true
                    attendeeListObserverableObj
                        .attendeeLogin(attendee: attendee) { root in
                            loaderObserver.showLoader = false
                            self.rootViewObserver.currentPage = root
                        }
                } else {
                    self.rootViewObserver.currentPage = .attendeePariningSetup
                }
            }
        } else {
            self.rootViewObserver.currentPage = .whichDeviceUsing
        }
        
    }
}


//struct AttendeeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeListView()
//            .multiPreview
//    }
//}
