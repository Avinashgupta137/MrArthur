//
//  managed.settings.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 07/11/2022.
//

import Foundation
import FamilyControls
import ManagedSettings

// EParentalControlSettingsPreset
class ManagedSettingsService {
    
    static func setParentalControlSettings(preset: EParentalControlSettingsPreset) {
        if (preset == .FROM_08) {
            ManagedSettingsService.setFROM08()
        } else if (preset == .FROM_10) {
            ManagedSettingsService.setFROM10()
        } else if (preset == .FROM_12) {
            ManagedSettingsService.setFROM12()
        }
    }
    
    static func setFROM08() {
        let managedStore = ManagedSettingsStore()
        managedStore.media.denyBookstoreErotica = true
        managedStore.media.denyExplicitContent = true
        managedStore.media.maximumTVShowRating = 300
        managedStore.media.maximumMovieRating = 100
        managedStore.appStore.maximumRating = 200
        managedStore.webContent.blockedByFilter = .auto(except: [])
    }
    
    static func setFROM10() {
        let managedStore = ManagedSettingsStore()
        managedStore.media.denyBookstoreErotica = true
        managedStore.media.denyExplicitContent = true
        managedStore.media.maximumTVShowRating = 400
        managedStore.media.maximumMovieRating = 200
        managedStore.appStore.maximumRating = 600
        managedStore.webContent.blockedByFilter = .auto(except: [])
    }
    
    static func setFROM12() {
        let managedStore = ManagedSettingsStore()
        managedStore.media.denyBookstoreErotica = true
        managedStore.media.denyExplicitContent = true
        managedStore.media.maximumTVShowRating = 500
        managedStore.media.maximumMovieRating = 400
        managedStore.appStore.maximumRating = 600
        managedStore.webContent.blockedByFilter = .auto(except: [])
    }
    
    static func setNoFilter() {
        let managedStore = ManagedSettingsStore()
        managedStore.media.denyBookstoreErotica = false
        managedStore.media.denyExplicitContent = false
        managedStore.media.maximumTVShowRating = 1000
        managedStore.media.maximumMovieRating = 1000
        managedStore.appStore.maximumRating = 1000
        managedStore.webContent.blockedByFilter = Optional<WebContentSettings.FilterPolicy>.none
    }
    
    static func dumpManagedStore() {
        let managedStore = ManagedSettingsStore()
        print("managedStore")
        dump(managedStore)
    }
    
    static func unlockPasswordToInstallApp() {
        let managedStore = ManagedSettingsStore()
        managedStore.appStore.requirePasswordForPurchases = false
        managedStore.appStore.denyInAppPurchases = false
        print("require pass for purshases \(managedStore.appStore.requirePasswordForPurchases)")
    }
    static func lockPasswordToInstallApp() {
        let managedStore = ManagedSettingsStore()
        managedStore.appStore.requirePasswordForPurchases = true
//        managedStore.appStore.denyInAppPurchases = true
        print("require pass for purshases \(managedStore.appStore.requirePasswordForPurchases)")
    }
    
    static func setDevAllowAll() {
        let managedStore = ManagedSettingsStore()
        managedStore.media.denyBookstoreErotica = true
        managedStore.media.denyExplicitContent = true
        managedStore.media.maximumTVShowRating = 1000
        managedStore.media.maximumMovieRating = 1000
        managedStore.appStore.maximumRating = 1000
        managedStore.webContent.blockedByFilter = .auto(except: [])
    }
}
