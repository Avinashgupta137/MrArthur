//
//  observer.gain.data.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 07/09/22.
//

import Foundation
import SwiftUI
extension ObserverGainDataView {
    class ObserverGainDataObserver: ObservableObject {
        var diagnosedScreenTimeMinutes: Int = 0
        var timeInMin = 0
        var timeInYear = 0
        
        init() {
            self.setData()
        }
        
        func setData() {
            if let attendee = UserDefaultsHelper.selectedAttendee {
                if let estimation = attendee.attendeeUserMediationList?.last?.stepListJsonb?.estimation {
                    self.diagnosedScreenTimeMinutes = estimation.diagnosedScreenTimeMinutes ?? 0
                }
                ///Calculation
                let T2 = ceil(Double(self.diagnosedScreenTimeMinutes) * 0.8)
                let T3 = ceil(T2 * 0.2)
                let T4 = ceil((T3 * 365) / 60)
                print("T2 : \(T2) : T3 : \(T3) : T4 : \(T4)")
                self.timeInMin = Int(T3)
                self.timeInYear = Int(T4)
            }
        }
    }
}
