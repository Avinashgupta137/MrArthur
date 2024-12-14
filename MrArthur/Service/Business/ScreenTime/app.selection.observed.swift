//
//  screen.time.observed.swift
//  MrArthur
//
//  Created by Reille Sebastien on 31/08/2022.
//

//import Foundation
//import FamilyControls
//import ManagedSettings
//import SwiftUI
//
//class AppSelectionObserved: ObservableObject {
//    static let shared = AppSelectionObserved()
//    let store = ManagedSettingsStore()
//    //@EnvironmentObject var store: ManagedSettingsStore
//    
//    @Published var entertainmentTimeSelection: FamilyActivitySelection
//    @Published var educationalTimeSelection: FamilyActivitySelection
//    @Published var allCategoriesTimeSelection: FamilyActivitySelection
//
//    init() {
//        entertainmentTimeSelection = FamilyActivitySelection()
//        educationalTimeSelection = FamilyActivitySelection()
//        allCategoriesTimeSelection = FamilyActivitySelection()
//    }
//
//    func setShieldRestrictions() {
//        // Pull the selection out of the app's model and configure the application shield restriction accordingly
//        let applications = AppSelectionObserved.shared.entertainmentTimeSelection
//        
//        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
//        store.shield.applicationCategories = applications.categoryTokens.isEmpty
//            ? nil
//            : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
//    }
//}
