//
//  device.activity.monitor.extension.swift
//  MrArthur
//
//  Created by Reille Sebastien on 01/09/2022.
//

import Foundation
import DeviceActivity

//
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        // TODO: give the attendee some entertainment time to begin the day
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        // TODO: block all apps if "rest time" set for the attendee
    }
}