//
//  infocom.message.service.swift
//  MrArthur
//
//  Created by Nirav Patel on 26/09/22.
//

import Foundation
import Intercom

class IntercomMessageService{
    func registerMail(email: String?){
        Intercom.setApiKey("ios_sdk-965c6e62bcb0551f61c78956de1689e03841ad82", forAppId:"sisu0x8u")
        Intercom.setLauncherVisible(false)
        Intercom.enableLogging()
        print("Updated Email: \(UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String)")
        if let email = email {
            let attributes = ICMUserAttributes()
            attributes.email = email
            Intercom.loginUser(with: attributes) { result in
                switch result {
                case .success: print("Successfully logged in \(email)")
                    Intercom.presentMessenger()
                    Intercom.unreadConversationCount()
                case .failure(let error): print("Error logging in: \(error.localizedDescription)")
                }
            }
        }
    }
    func logoutUser(){
        Intercom.logout()
    }
}
