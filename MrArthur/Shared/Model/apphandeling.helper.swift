//
//  AppHandeling.swift
//  MrArthur
//
//  Created by IPS-157 on 03/08/22.
//

import Foundation

let sUserDefault = UserDefaults.standard
let sUserLoginStatus = "UserLoginStatus"
let sWelcomeBtnStatus = "WelcomeBtnStatus"

class AppDetails : NSCoder,Codable{
}

extension AppDetails{
    
    static func setLoginStatus(status : Bool){
        sUserDefault.setValue(status, forKey:sUserLoginStatus)
        sUserDefault.synchronize()
    }
    
    static func getLoginStatus() -> Bool{
        if let status = sUserDefault.value(forKey: sUserLoginStatus) as? Bool{
            if status {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    static func setWelcomeButtonStatus(status : Bool){
        sUserDefault.setValue(status, forKey:sWelcomeBtnStatus)
        sUserDefault.synchronize()
    }
    
    static func getWelcomeButtonStatus() -> Bool{
        if let status = sUserDefault.value(forKey: sWelcomeBtnStatus) as? Bool{
            if status {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
}
