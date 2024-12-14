//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityExtension
//
//  Created by Reille Sebastien on 01/09/2022.
//

import DeviceActivity
import os.log
import SwiftUI
import MobileCoreServices
import ManagedSettings
import FamilyControls
import Foundation

let serialQueuedDeviceActivityMonitor = DispatchQueue(
    label: "mrarthur.device.activity.monitor.serial.queue"
)

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        if (activity == DeviceActivityName.entertainmentActivityName) {
            
        } else if (activity == DeviceActivityName.educationalActivityName) {
           
        } else if (activity == DeviceActivityName.restPeriodActivityName) {
            // Morning start
            serialQueuedDeviceActivityMonitor.async {
                ExtensionDeviceActivityService.morningStart()
            }
            serialQueuedDeviceActivityMonitor.async {
                ExtensionApiCallService.sendLog(log: "Morning start - Rest period ended")
            }
        } else if (activity == DeviceActivityName.allCategoriesActivityName) {
            
        } else if (activity.rawValue.contains("slot")) {
            ExtensionDeviceAcivitySlotService.handleSlotIntervalEvent(
                activityName: activity,
                type: .START
            )
        }
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        if (activity == DeviceActivityName.entertainmentActivityName) {
            
        } else if (activity == DeviceActivityName.educationalActivityName) {
        
        } else if (activity == DeviceActivityName.restPeriodActivityName) {
            serialQueuedDeviceActivityMonitor.async {
                if (ExtensionRestPeriodService.getHasRestPeriod() && ExtensionRestPeriodService.isInRestPeriod()) {
                    ExtensionScreenTimePermissionService.blockAllCategories()
                }
            }
            serialQueuedDeviceActivityMonitor.async {
                ExtensionApiCallService.sendLog(log: "Rest period started")
            }
        } else if (activity == DeviceActivityName.allCategoriesActivityName) {
            
        } else if (activity.rawValue.contains("slot")) {
            ExtensionDeviceAcivitySlotService.handleSlotIntervalEvent(
                activityName: activity,
                type: .END
            )
        }
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        if (activity == DeviceActivityName.entertainmentActivityName) {
            
        } else if (activity == DeviceActivityName.educationalActivityName) {
            
        } else if (activity == DeviceActivityName.restPeriodActivityName) {
            
        } else if (activity == DeviceActivityName.allCategoriesActivityName) {
            
        } else if (activity.rawValue.contains("slot")) {
            ExtensionDeviceAcivitySlotService.handleSlotIntervalEvent(
                activityName: activity,
                type: .WARNING_START
            )
        }
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        if (activity == DeviceActivityName.entertainmentActivityName) {
            
        } else if (activity == DeviceActivityName.educationalActivityName) {
           
        } else if (activity == DeviceActivityName.restPeriodActivityName) {
            
        } else if (activity == DeviceActivityName.allCategoriesActivityName) {
            
        } else if (activity.rawValue.contains("slot")) {
            ExtensionDeviceAcivitySlotService.handleSlotIntervalEvent(
                activityName: activity,
                type: .WARNING_END
            )
        }
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
//        if (activity.rawValue.contains("entertainmentCorrection")) {
//            let secondSpent: Int? = ExtensionDeviceActivityService.getSecondFromEvent(activityName: activity, eventName: event)
//            ExtensionEntertainmentService.setCorrectionEntertainmentSTSecondSpentDayLocalDevice(second: secondSpent)
//        }
        
        if (event == DeviceActivityEvent.Name.entertainmentEventName) {
            ExtensionEntertainmentService.increaseEntertainmentSTSecondSpentDayLocalDevice()
            
            if (!ExtensionScreenTimePermissionService.canUseEntertainmentCategory()) {
                ExtensionScreenTimePermissionService.blockEntertainmentCategory()
                ExtensionDeviceActivityCorrectionService.stopMonitoringEntertainmentCorrection()
            } else {
                ExtensionDeviceActivityService.scheduleEntertainmentActivity()
            }
        } else if (event == DeviceActivityEvent.Name.educationalEventName) {
            ExtensionEducationalService.increaseEducationalSTSecondSpentDayLocalDevice()
            if (!ExtensionScreenTimePermissionService.canUseEducationalCategory()) {
                ExtensionScreenTimePermissionService.blockEducationalAndEntertainmentCategory()
            } else {
                ExtensionDeviceActivityService.scheduleEducationalActivity()
            }
        } else if (event == DeviceActivityEvent.Name.restPeriodEventName) {
            
        } else if (event == DeviceActivityEvent.Name.allCategoriesEventName) {
            ExtensionAllCategoriesService.increaseAllCategoriesSTSecondSpentDayLocalDevice()
            ExtensionDeviceActivityService.scheduleAllCategoriesActivity()
        }
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
    }
}
