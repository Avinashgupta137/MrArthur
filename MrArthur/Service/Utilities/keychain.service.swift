//
// Created by Reille Sebastien on 19/08/2022.
//

import Foundation
import KeychainAccess

enum EKeychainKey: String {
    case CURRENT_USER_TOKEN = "CURRENT_USER_TOKEN"
}

enum EKeychainGroupKey: String {
    case CURRENT_USER_TOKEN = "CURRENT_USER_TOKEN"
}

class KeychainService {
    static let shared = KeychainService()
    private static var service: String = "io.mrarthur.app"
    private static var accessGroup: String = "7ACP5Z84ZQ.io.mrarthur.sharedItems"
    public var keychain = Keychain(service: KeychainService.service)
    public var keychainGroup = Keychain(service: KeychainService.service, accessGroup: KeychainService.accessGroup)

    public static func getKeychainValue(key: EKeychainKey) -> String? {
        let value: String? = KeychainService.shared.keychain[key.rawValue]
        return value
    }
    
    public static func setKeychainValue(key: EKeychainKey, value: String) -> Bool {
        do {
            if (key == EKeychainKey.CURRENT_USER_TOKEN) {
                let _ = KeychainService.setKeychainGroupValue(key: EKeychainGroupKey.CURRENT_USER_TOKEN, value: value)
                ExtensionApiCallService.setUserTokenHasChanged(value: true)
            }
            try KeychainService.shared.keychain.set(value, key: key.rawValue)
            return true
        } catch {
            return false
        }
    }
    
    public static func getKeychainGroupValue(key: EKeychainGroupKey) -> String? {
        let value: String? = KeychainService.shared.keychainGroup[key.rawValue]
        return value
    }
    
    public static func setKeychainGroupValue(key: EKeychainGroupKey, value: String) -> Bool {
        do {
            try KeychainService.shared.keychainGroup.set(value, key: key.rawValue)
            return true
        } catch {
            return false
        }
    }
}
