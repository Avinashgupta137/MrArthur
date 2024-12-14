//
//  screen.time.test.swift
//  MrArthur
//
//  Created by Reille Sebastien on 31/08/2022.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import Swift

struct screen_time_view: View {
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentFamilyActivitySelection = FamilyActivitySelection()
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalFamilyActivitySelection = FamilyActivitySelection()
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ALL_CATEGORY_FAMILY_ACTIVITY_SELECTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var allCategoryFamilyActivitySelection = FamilyActivitySelection()

    @AppStorage(
            ExtensionSharedAppGroupService.keys.FORBIDDEN_BROWSERS_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
    ) var forbiddenBrowsersFamilyActivitySelection = FamilyActivitySelection()

    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_TIME_LEFT,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondTimeLeft: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_MORNING_ADVANCE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondMorningAdvance: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_ADVANTAGE_OVER_YESTERDAY_CONSUMPTION,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSecondAdvantageOverYesterday: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSeconTimeSpentLocal: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.ENTERTAINMENT_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var entertainmentSTSeconTimeSpentMulti: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_LOCAL_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTSeconTimeSpentLocal: Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_SECOND_SPENT_DAY_MULTI_DEVICE,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTSeconTimeSpentMulti: Int = 0

    @AppStorage(
        ExtensionSharedAppGroupService.keys.EVENT_TIME_ADD,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var eventTimeInSecond : Int = 0
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.TEST_KEY,
        store: ExtensionSharedAppGroupService.sharedDefault
    )
    var testViewObs: String = "testViewObs"

    @State var eventTime : String = ""
    @State private var isEntertainmentTimeSelectionPresented = false
    @State private var isEducationalTimeSelectionPresented = false
    @State private var isAllCategoriesTimeSelectionPresented = false
    @State private var isForbiddenBrowsersTimeSelectionPresented = false
//    @StateObject var myScreenTimeSchedule = ScreenTimeSchedule.shared
//    @EnvironmentObject var appSelectionObserved: AppSelectionObserved
    @FocusState private var timeIsFocused: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // Test view obs
//                Text("Test view obs: \(testViewObs)").padding()
                Text("TL: \(entertainmentSTSecondTimeLeft) MAd: \(entertainmentSTSecondMorningAdvance) AOY: \(entertainmentSTSecondAdvantageOverYesterday) ETSL: \(entertainmentSTSeconTimeSpentLocal) ETSM: \(entertainmentSTSeconTimeSpentMulti) EdTSL: \(educationalSTSeconTimeSpentLocal) EdTSM: \(educationalSTSeconTimeSpentMulti)").padding()
                
                // Revoke authorization
                Button("RevokeAuthorization"){
                    FamilyControlService.revokeAuthorization()
                }
                .padding()
                
                // Screen Time Auth
                Button("Set auth") {
                   // FamilyControlService.setAuthorization()
                }
                .padding()
                // Entertainment
                Button("Select entertainment Categories") {
                    isEntertainmentTimeSelectionPresented = true
                }
                .familyActivityPicker(
                    isPresented: $isEntertainmentTimeSelectionPresented,
                    //                selection: $screenTimeObserved.entertainmentTimeSelection
                    //                selection: $myScreenTimeSchedule.entertainmentTimeSelection
                    selection: $entertainmentFamilyActivitySelection
                    
                )
                .padding()
                // Educational
                Button("Select educational Categories") {
                    isEducationalTimeSelectionPresented = true
                }
                .familyActivityPicker(
                    isPresented: $isEducationalTimeSelectionPresented,
//                    selection: $appSelectionObserved.educationalTimeSelection
                    selection: $educationalFamilyActivitySelection
                )
                .padding()
                
                // All Categories
                Button("Select all Categories") {
                    isAllCategoriesTimeSelectionPresented = true
                }
                .familyActivityPicker(
                    isPresented: $isAllCategoriesTimeSelectionPresented,
//                    selection: $appSelectionObserved.allCategoriesTimeSelection
                    selection: $allCategoryFamilyActivitySelection
                )
                .padding()
                // All Categories
                Button("Select forbidden browser") {
                    isForbiddenBrowsersTimeSelectionPresented = true
                }
                .familyActivityPicker(
                    isPresented: $isForbiddenBrowsersTimeSelectionPresented,
//                    selection: $appSelectionObserved.allCategoriesTimeSelection
                    selection: $forbiddenBrowsersFamilyActivitySelection
                )
                .padding()
//                VStack{
//                    Text("Add Time For interval Start")
//                        .padding()
//                    TextField("Enter Seconds", text: $eventTime)
//                        .focused($timeIsFocused)
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(Color.black)
//                        .font(AppFont.MontserratRegularFont(fontSize: 20))
//                        .frame(height: 50)
//                        .multilineTextAlignment(.center)
//                        .background(Color.white.cornerRadius(67.resizable/2))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 67.resizable / 2)
//                                .stroke(Color.red, lineWidth: 3)
//                        )
//                }
//                .padding(.horizontal, 75)
                // Set Schedule
//                .padding(.bottom, 20)
                Button("Start dev scenario") {
                    timeIsFocused = false
//                    if Int(eventTime) ?? 0 > 0{
//                        eventTimeInSecond = Int(eventTime) ?? 0
//                        print("Send Time: \(eventTimeInSecond)")
//                        myScreenTimeSchedule.setSchedule()
//                    }
//                    ScreenTimeScheduleService.setSchedule()
//                    ExtensionDeviceActivityService.scheduleEntertainmentActivity()
                    ExtensionScreenTimeDevTestScenarioService.loadBasicScenario()
                }
                
                // Stop Montering
                Button("Stop Monitoring all activities"){
//                    ScreenTimeSchedule.stopMonitoring()
                    ExtensionDeviceActivityService.stopMonitoringAllActivities()
                }
                .padding()
//                Spacer()
            }
            .onChange(
                of: entertainmentFamilyActivitySelection
            ) { newSelection in
                print("category count \(entertainmentFamilyActivitySelection.categories.count)" )
                print("category token count \(entertainmentFamilyActivitySelection.categoryTokens.count)" )
                print("application  count \(entertainmentFamilyActivitySelection.applications.count)" )
                print("application token  count \(entertainmentFamilyActivitySelection.applicationTokens.count)" )
                print("webDomains count \(entertainmentFamilyActivitySelection.webDomains.count)" )
                print("webDomains token count \(entertainmentFamilyActivitySelection.webDomainTokens.count)" )
            }
        }
    }
}

struct screen_time_view_Previews: PreviewProvider {
    static var previews: some View {
        screen_time_view()
    }
}
