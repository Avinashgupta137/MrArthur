//
//  attendee.restperiodselection.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//

import Foundation
import Foundation

struct RestPeriod: Codable, Identifiable {
    var id: Int
    var icon: String
    var label: String
    var request: EResetTime
    var isSelected: Bool = false
    var isBorder: Bool = false
}

extension AttendeeRestPeriodSelectionView{
    class AttendeeRestPeriodSelectionObserved:ObservableObject{
        
        @Published var selectedRestIndex: Int? = nil
        var controllSettingResponse: ParentalControlSettingsResponse?
        
        func getList() -> [RestPeriod] {
            return [
                RestPeriod(
                    id: 0,
                    icon:"SettingsFilteringTime01",
                    label: "19h00-08h00",
                    request: .TO19_08,
                    isSelected: selectedRestIndex == 0,
                    isBorder: controllSettingResponse?.restPeriod == EResetTime.TO19_08 ? true
                    : false
                ),
                RestPeriod(
                    id: 1,
                    icon:"SettingsFilteringTime02",
                    label: "21h00-07h00",
                    request: .TO21_07,
                    isSelected: selectedRestIndex == 1,
                    isBorder: controllSettingResponse?.restPeriod == EResetTime.TO21_07 ? true
                    : false
                ),
                RestPeriod(
                    id: 2,
                    icon:"SettingsFilteringTime03",
                    label: "23h00-06h00",
                    request: .TO23_06,
                    isSelected: selectedRestIndex == 2,
                    isBorder: controllSettingResponse?.restPeriod == EResetTime.TO23_06 ? true
                    : false
                ),
                RestPeriod(
                    id: 3,
                    icon:"SettingsFilteringTime04",
                    label: "No rest period",
                    request: .NO_REST,
                    isSelected: selectedRestIndex == 3,
                    isBorder: controllSettingResponse?.restPeriod == EResetTime.NO_REST ? true
                    : false
                )
            ]
        }
        
        func setRestPeriod(item: RestPeriod, completion: @escaping () -> () ) {
            RestPeriodService.setLocalRestPeriod(restPeriod: item.request)
            ResetTimeSetting.updateresetTimeSettingAPICall(
                restPeriod: item.request
            ) { status, message, response in

                var  deviceSetupStatus = UserDefaultsHelper.paringDevice
                deviceSetupStatus.contentFilteringDone = true
                UserDefaultsHelper.paringDevice =  deviceSetupStatus
                if let settings = response {
                    print("Response pdate reset time response = \(settings)")
                }
                completion()
            }
        }
    }
}
