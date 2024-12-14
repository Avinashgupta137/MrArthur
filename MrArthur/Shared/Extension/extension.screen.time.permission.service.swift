//
//  screen.time.permission.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 01/10/2022.
//

import Foundation
import ManagedSettings
import FamilyControls
import SwiftUI

struct EntertainmentUnlockedTimeModel {
    var entertainmentUnlockedTimeSecond, eudcationalQuarterOngoing: Int
    var hasReachedEducationalNewQuarter: Bool
}

class ExtensionScreenTimePermissionService {
    static func canUseEntertainmentCategory() -> Bool {
        // > 1 because by the time the attendde is blocked 1 second has passed
        return ExtensionScreenTimePermissionService.getEntertainmentScreenTimeSecondLeftToday() >= 1
    }
    
    static func canUseEducationalCategory() -> Bool {
        let entertainementTimeLeft: Int = ExtensionScreenTimePermissionService.getEntertainmentScreenTimeSecondLeftToday()
        let educationalTimeSpent: Int = ExtensionScreenTimePermissionService.getEducationalTimeSecondSpentToday()
        let educationalTimeCommitment: Int = ExtensionEducationalService.getEducationalSTSecondPerDayCommitment()
        // Attendee can use his entertainement time to do educational time
        return educationalTimeSpent < educationalTimeCommitment || entertainementTimeLeft > 0
    }
    
    static func getTotalScreenTimePerDayAllowdSecond() -> Int {
        // entertainment total allowed + educational screen time allowed
        let entertainmentTimeAllowed: Int = ExtensionEntertainmentService.getEntertainmentSTSecondPerDayAllowed()
        let educationalTimeCommitment: Int = ExtensionEducationalService.getEducationalSTSecondPerDayCommitment()
        return entertainmentTimeAllowed + educationalTimeCommitment
    }
    
    static func getEntertainmentTimeSecondSpentToday() -> Int {
        let entertainmentTimeSpentLocalDevice: Int = ExtensionEntertainmentService.getEntertainmentSTSecondSpentDayLocalDevice()
        let entertainmentTimeSpentMultiDevice: Int = ExtensionEntertainmentService.getEntertainmentSTSecondSpentDayMultiDevice()
        let entertainmentTimeSpent: Int = entertainmentTimeSpentMultiDevice > entertainmentTimeSpentLocalDevice ?
            entertainmentTimeSpentMultiDevice : entertainmentTimeSpentLocalDevice
        return entertainmentTimeSpent
    }
    
    static func getEducationalTimeSecondSpentToday() -> Int {
        let educationalTimeSpentLocalDevice: Int = ExtensionEducationalService.getEducationalSTSecondSpentDayLocalDevice()
        let educationalTimeSpentMultiDevice: Int = ExtensionEducationalService.getEducationalSTSecondSpentDayMultiDevice()
        let educationalTimeSpent: Int = educationalTimeSpentMultiDevice > educationalTimeSpentLocalDevice ?
            educationalTimeSpentMultiDevice : educationalTimeSpentLocalDevice
        return educationalTimeSpent
    }
    
    static func getAdvanceOfToday() -> Int {
        let advance: Int = ExtensionEntertainmentService.getEntertainmentSTSecondMorningAdvance()
        let advantage: Int = ExtensionEntertainmentService.getEntertainmentSTSecondAdvantageOverYesterdayConsumption()
        return advance + advantage
    }
    
    static func getUnlockedEntertainmentTimeModel() -> EntertainmentUnlockedTimeModel {
        let educationalTimeSpentSecond: Int = ExtensionScreenTimePermissionService.getEducationalTimeSecondSpentToday()
        let educationalQuarter: QuartersFromSecondModel = ExtensionEducationalService.getAllQuarters()
        let entertainmentQuarter: QuartersFromSecondModel = ExtensionEntertainmentService.getAllQuarters()
        var unlockedTime: Int = 0
        var quarterOngoing: Int = 0
        if (educationalTimeSpentSecond >= educationalQuarter.quarter1) {
            unlockedTime += entertainmentQuarter.quarter1
            quarterOngoing = 1
        }
        let educationalQuarter2Addition = educationalQuarter.quarter1 + educationalQuarter.quarter2
        if (educationalTimeSpentSecond >= educationalQuarter2Addition) {
            unlockedTime += entertainmentQuarter.quarter2
            quarterOngoing = 2
        }
        let educationalQuarter3Addition = educationalQuarter2Addition + educationalQuarter.quarter3
        if (educationalTimeSpentSecond >= educationalQuarter3Addition) {
            unlockedTime += entertainmentQuarter.quarter3
            quarterOngoing = 3
        }
        let educationalQuarter4Addition = educationalQuarter3Addition + educationalQuarter.quarter4
        if (educationalTimeSpentSecond >= educationalQuarter4Addition) {
            unlockedTime += entertainmentQuarter.quarter4
            quarterOngoing = 4
        }
        
        let oldQuarterOngoing: Int = ExtensionEducationalService.getEducationalSTQuarterOnGoing()
        let hasReachedNewQuarter: Bool = quarterOngoing > oldQuarterOngoing
        
        if (hasReachedNewQuarter) {
            ExtensionEducationalService.setEducationalSTQuarterOnGoing(number: quarterOngoing)
            if (
                !ExtensionApiCallService.callHasToBeDoneFromModulo(
                    secondSpent: educationalTimeSpentSecond,
                    screenTimeType: EScreenTimeType.EDUCATIONAL
                )
            ) {
                ExtensionApiCallService.postAttendeeTimeSpent(
                    secondSpent: educationalTimeSpentSecond,
                    screenTimeType: EScreenTimeType.EDUCATIONAL,
                    withModulo: false
                )
            }
            
            ExtensionScreenTimePermissionService.unblockEntertainmentCategory()
            ExtensionDeviceActivityService.stopMonitoringEntertainment()
            ExtensionDeviceActivityService.scheduleEntertainmentActivity()
        }
        
//        return unlockedTime
        return EntertainmentUnlockedTimeModel(
            entertainmentUnlockedTimeSecond: quarterOngoing == 0 ? ExtensionScreenTimePermissionService.getAdvanceOfToday() : unlockedTime,
            eudcationalQuarterOngoing: quarterOngoing,
            hasReachedEducationalNewQuarter: hasReachedNewQuarter
        )
    }
    
    static func getEducationalTimeSpentCommitmentExceededSecond() -> Int {
        let educationalTimeSpentSecond: Int = ExtensionScreenTimePermissionService.getEducationalTimeSecondSpentToday()
        let educationalTimeCommitment: Int = ExtensionEducationalService.getEducationalSTSecondPerDayCommitment()
        let exceededTime: Int = educationalTimeSpentSecond - educationalTimeCommitment
        return exceededTime > 0 ? exceededTime : 0
    }
    
    static func getEntertainmentScreenTimeSecondLeftToday() -> Int {
        // Entertainement time spent (total local device or multi device)
        let entertainmentTimeSpentSecond: Int = ExtensionScreenTimePermissionService.getEntertainmentTimeSecondSpentToday()
     
        // Advance
        let entertainmentAdvance = ExtensionScreenTimePermissionService.getAdvanceOfToday()
        
        // Unlocked time
        let unlockedEntertainmentModel: EntertainmentUnlockedTimeModel = ExtensionScreenTimePermissionService
            .getUnlockedEntertainmentTimeModel()
        let unlockedEntertainmentTime: Int = unlockedEntertainmentModel.entertainmentUnlockedTimeSecond
        var timeLeft: Int = entertainmentAdvance
        
        if (unlockedEntertainmentTime >= 0 && entertainmentAdvance < 0) {
            timeLeft = (unlockedEntertainmentTime + entertainmentAdvance) - entertainmentTimeSpentSecond
        } else if (unlockedEntertainmentTime > 0 && entertainmentAdvance >= 0) {
            timeLeft = unlockedEntertainmentTime - entertainmentTimeSpentSecond
        } else {
            timeLeft -= entertainmentTimeSpentSecond
        }
        
        timeLeft -= ExtensionScreenTimePermissionService.getEducationalTimeSpentCommitmentExceededSecond()
        ExtensionEntertainmentService.setEntertainmentSTSecondTimeLeft(second: timeLeft)
        
        print("getEntertainmentScreenTimeSecondLeftToday: \(timeLeft)")
        return timeLeft
    }
    
    static func getComputedEntertainmentSTSecondAdvantageOverYesterdayConsumption() -> Int {
        let entertainmentTimeSpent: Int = ExtensionScreenTimePermissionService.getEntertainmentTimeSecondSpentToday()
        let educationalTimeSpent: Int = ExtensionScreenTimePermissionService.getEducationalTimeSecondSpentToday()
        let entertainmentTimeAllowed: Int = ExtensionEntertainmentService.getEntertainmentSTSecondPerDayAllowed()
        var advantage: Int = 0
        
        if (entertainmentTimeSpent >= entertainmentTimeAllowed) {
            advantage = entertainmentTimeAllowed - entertainmentTimeSpent
        } else {
//            let unlockedEntertainmentTime: Int = ExtensionScreenTimePermissionService.getUnlockedEntertainmentScreenTimeSecond()
            // Unlocked time
            let unlockedEntertainementModel: EntertainmentUnlockedTimeModel = ExtensionScreenTimePermissionService
                .getUnlockedEntertainmentTimeModel()
            let unlockedEntertainmentTime: Int = unlockedEntertainementModel.entertainmentUnlockedTimeSecond
            let entertainmentTimeNotConsummed: Int = educationalTimeSpent > 0
                ? unlockedEntertainmentTime - entertainmentTimeSpent : 0
            if (entertainmentTimeNotConsummed <= 0) {
                advantage = 0
            } else {
                let unlockedEntertainementTime50PercentInt: Int = Int(ceil(Double(entertainmentTimeNotConsummed / 2)))
                advantage = unlockedEntertainementTime50PercentInt
            }
        }
        
//        print("getComputedEntertainmentSTSecondAdvantageOverYesterdayConsumption: \(advantage)")
        return advantage
    }

    // case attendee has spent all entertainment time or he has to do educational time to unblock it
    static func blockEntertainmentCategory() {
        let managedStore = ManagedSettingsStore()
        managedStore.shield.applications = ExtensionFamilyActivitySelectionService.getForbiddenBrowsersSelection().applicationTokens
        managedStore.shield.applicationCategories = .specific(
            ExtensionFamilyActivitySelectionService.getEntertainmentSelection().categoryTokens
        )
        
        managedStore.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(
            ExtensionFamilyActivitySelectionService.getEntertainmentSelection().categoryTokens,
            except: Set()
        )
        managedStore.shield.webDomains = ExtensionFamilyActivitySelectionService.getEntertainmentSelection().webDomainTokens
        
        managedStore.dateAndTime.requireAutomaticDateAndTime = true
        ExtensionDeviceActivityService.stopMonitoringEntertainment()
        ExtensionEntertainmentService.setEntertainmentCategoriesBlocked(value: true)
        // TODO: set shield text (maybe directly in shieldExtension)
    }

    // case attendee has unblocked time by doing educational time
    static func unblockEntertainmentCategory() {
        let managedStore = ManagedSettingsStore()
        dump(ExtensionFamilyActivitySelectionService.getForbiddenBrowsersSelection().applicationTokens)
        managedStore.shield.applications = ExtensionFamilyActivitySelectionService.getForbiddenBrowsersSelection().applicationTokens
        managedStore.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
        
        managedStore.shield.webDomains = []
        managedStore.shield.webDomainCategories = ShieldSettings.webDomainCategories.defaultValue
        
        managedStore.dateAndTime.requireAutomaticDateAndTime = true
        ExtensionEntertainmentService.setEntertainmentCategoriesBlocked(value: false)
        // TODO: set shield text (maybe directly in shieldExtension)
    }

    // case attendee has spent total time per day
    static func blockEducationalAndEntertainmentCategory() {
        let managedStore = ManagedSettingsStore()
        managedStore.shield.applications = ExtensionFamilyActivitySelectionService.getForbiddenBrowsersSelection().applicationTokens
        managedStore.shield.applicationCategories = .specific(
            ExtensionFamilyActivitySelectionService.getEntertainmentSelection().categoryTokens.union(
                ExtensionFamilyActivitySelectionService.getEducationalSelection().categoryTokens
            )
        )
        
        managedStore.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(
            ExtensionFamilyActivitySelectionService.getEntertainmentSelection().categoryTokens.union(
                ExtensionFamilyActivitySelectionService.getEducationalSelection().categoryTokens
            ),
            except: Set()
        )
        managedStore.shield.webDomains = ExtensionFamilyActivitySelectionService.getEntertainmentSelection().webDomainTokens.union(
            ExtensionFamilyActivitySelectionService.getEducationalSelection().webDomainTokens
        )
        
        managedStore.dateAndTime.requireAutomaticDateAndTime = true
        ExtensionEntertainmentService.setEntertainmentCategoriesBlocked(value: true)
        // TODO: set shield text (maybe directly in shieldExtension)
    }

    // case rest period time is reached
    static func blockAllCategories() {
        let managedStore = ManagedSettingsStore()
        managedStore.shield.applications = .none
        managedStore.shield.applicationCategories = .specific(
            ExtensionFamilyActivitySelectionService.getAllCategoriesSelection().categoryTokens
        )
        
        managedStore.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(
            ExtensionFamilyActivitySelectionService.getAllCategoriesSelection().categoryTokens,
            except: Set()
        )
        managedStore.shield.webDomains = ExtensionFamilyActivitySelectionService.getAllCategoriesSelection().webDomainTokens
        
        managedStore.dateAndTime.requireAutomaticDateAndTime = true
        ExtensionEntertainmentService.setEntertainmentCategoriesBlocked(value: true)
    }

    // case rest period time is ended and a new day begins
    static func unblockAllCategories() {
        let managedStore = ManagedSettingsStore()
        managedStore.shield.applications = ExtensionFamilyActivitySelectionService.getForbiddenBrowsersSelection().applicationTokens
        managedStore.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
        
        managedStore.shield.webDomains = []
        managedStore.shield.webDomainCategories = ShieldSettings.webDomainCategories.defaultValue
        
        managedStore.dateAndTime.requireAutomaticDateAndTime = true
        ExtensionEntertainmentService.setEntertainmentCategoriesBlocked(value: false)
        // TODO: set shield text (maybe directly in shieldExtension)
    }
}
