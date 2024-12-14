//
//  ObserverMoreMainView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 04/08/22.
//

import Foundation

import SwiftUI

extension ObserverMoreMainView{
    class Observed:ObservableObject{
        @Published var canAddChild : Bool = true
        init() {
            if let localData = UserDefaultsHelper.currentUserAttenseeListData {
                if let list : [AttendeeListResponseModel] = try? APIHelper.shared.decodeStickers(from: localData){
                    self.canAddChild = list.count < 5
                }
            }
            AmplitudeService.sendEvent(
                key: .ATT_PLUS_MENU
            )
        }
    }
}
