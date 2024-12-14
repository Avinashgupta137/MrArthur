//
//  extension.widget.data.source.swift
//  MrArthur
//
//  Created by BAPS on 12/01/23.
//

import Foundation
import WidgetKit

class ExtensionWidgetDataSource {
    
    static let ATTUUID = "WIDGET_DATA_SOURCE_ATT_UUID"
    static let OBSTOKEN = "WIDGET_DATA_SOURCE_OBS_TOKEN"
    static let sharedDefault = UserDefaults(suiteName: "group.extension-target")
    
    static func setObserverToken(_ token: String?) {
        if let userDefaults = sharedDefault {
            userDefaults.set(token, forKey: OBSTOKEN)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    static func setCurrrentAttendeeUUID(_ uuid: String?) {
        if let userDefaults = sharedDefault {
            userDefaults.set(uuid, forKey: ATTUUID)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    static func getObserverToken() -> String? {
        if let userDefaults = sharedDefault {
            return userDefaults.string(forKey: OBSTOKEN)
        }
        return nil
    }
    
    static func getCurrrentAttendeeUUID() -> String? {
        if let userDefaults = sharedDefault {
            return userDefaults.string(forKey: ATTUUID)
        }
        return nil
    }
}
