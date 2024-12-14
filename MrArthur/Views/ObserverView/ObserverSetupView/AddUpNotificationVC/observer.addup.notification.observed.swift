//
//  observer.addup.notification.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 06/09/22.
//


import Foundation
import SwiftUI

struct SignInResponeRoute: Codable {
    var manifestoIndex: Int?
    var howitworkIndex: Int?
    var rootScreen: String?
}

//extension ObserverAddupNotificationView {
//    class Observed:ObservableObject{
//        @Published var isAllowed: Bool
//        func notificationEnablePopup(){
//            DispatchQueue.main.async {
//                Task{
//                    self.isAllowed =  await PushNotificationsService.setPermission()
//                }
//            }
//        }
//    }
//}
