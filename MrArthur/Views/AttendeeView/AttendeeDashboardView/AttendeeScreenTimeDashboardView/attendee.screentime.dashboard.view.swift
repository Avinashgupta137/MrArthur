//
//  attendee.screentime.dashboard.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 03/11/22.
//

import SwiftUI

struct AttendeeScreenTimeDashboardView: View {
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_PER_DAY_ALLOWED,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondPerDayAllowed: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_PER_DAY_COMMITMENT,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTSecondPerDayCommitment: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondSpentDayLocalDevice: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondSpentDayMultiDevice: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_TIME_LEFT,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondTimeLeft: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTSecondSpentDayLocalDevice: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTSecondSpentDayMultiDevice: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ALL_CATEGORIES_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var allCategoriesSTSecondSpentDayMultiDevice: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE_DOUBLE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondSpentDayLocalDeviceDouble: Double = 0
    
    @State var entTimeSpent: Int = 0
    func setEntertainementTimeSpent() -> Void {
        entTimeSpent = entertainmentSTSecondSpentDayMultiDevice > entertainmentSTSecondSpentDayLocalDevice
                            ? entertainmentSTSecondSpentDayMultiDevice : entertainmentSTSecondSpentDayLocalDevice
    }
    
    @State var edTimeSpent: Int = 0
    func setEducationalTimeSpent() -> Void {
        edTimeSpent = educationalSTSecondSpentDayMultiDevice > educationalSTSecondSpentDayLocalDevice
                            ? educationalSTSecondSpentDayMultiDevice : educationalSTSecondSpentDayLocalDevice
    }
    var body: some View {
        ScrollView{
            VStack{
//                Text("timeSpentEnLocal \(entertainmentSTSecondSpentDayLocalDevice)")
//                Text("timeSpentEnMulti \(entertainmentSTSecondSpentDayMultiDevice)")
//                Text("timeSpentEnMulti \(entertainmentSTSecondSpentDayLocalDeviceDouble)")

//                Text("timeSpentAllCatMulti \(allCategoriesSTSecondSpentDayMultiDevice)")
//                Text("edTimeSpentLocal \(educationalSTSecondSpentDayLocalDevice)")
//                Text("edTimeSpentMulti \(educationalSTSecondSpentDayMultiDevice)")
//                Text("totalScreenTime \((entertainmentSTSecondPerDayAllowed))")
//                Text("entertainmentSTSecondTimeLeft \((entertainmentSTSecondTimeLeft))")

                AttendeeDashboardUserView()
               
                AttendeeDashboardDateView(
                    dateString: DateService.shared.getCurrentDate()
                )
                
                AttendeeDashboardProgressCardView(
                    entertainmentTimeLeft: $entertainmentSTSecondTimeLeft,
                    
//                    entertainmentTimeSpent: entertainmentSTSecondSpentDayMultiDevice > entertainmentSTSecondSpentDayLocalDevice
//                    ? $entertainmentSTSecondSpentDayMultiDevice : $entertainmentSTSecondSpentDayLocalDevice,
                    entertainmentTimeSpent: $entTimeSpent,
                    
                    entertainmentTotalTime: $entertainmentSTSecondPerDayAllowed,
                    
                    educationalTimeSpent: $edTimeSpent,
                    
//                    educationalTimeSpent: educationalSTSecondSpentDayMultiDevice > educationalSTSecondSpentDayLocalDevice
//                    ? $educationalSTSecondSpentDayMultiDevice : $educationalSTSecondSpentDayLocalDevice,
                    
                    educationalTotalTime: $educationalSTSecondPerDayCommitment
                )
                .onChange(of: entertainmentSTSecondSpentDayMultiDevice) { newValue in
                    self.setEntertainementTimeSpent()
                }
                .onChange(of: entertainmentSTSecondSpentDayLocalDevice) { newValue in
                    self.setEntertainementTimeSpent()
                }
                .onChange(of: educationalSTSecondSpentDayMultiDevice) { newValue in
                    self.setEducationalTimeSpent()
                }
                .onChange(of: educationalSTSecondSpentDayLocalDevice) { newValue in
                    self.setEducationalTimeSpent()
                }
                
                Spacer()
            }
            .padding()
        }
        .customNavigationView(
            title: "Dashboard".localized,
            color: .white
        )
        .background(Color.secondaryRed)
        .onAppear {
            // call mediation to get screen time information and launch screen time process
            MediationService().handleLatestAcceptedMediation()
            self.setEntertainementTimeSpent()
            self.setEducationalTimeSpent()
            SubscriptionService.setBlockScreenStatus()
            
            //!\ only dev, TODO: comment
//            ManagedSettingsService.setDevAllowAll()
        }
    }
}
//
//struct AttendeeScreenTimeDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeScreenTimeDashboardView()
//            .multiPreview
//    }
//}
