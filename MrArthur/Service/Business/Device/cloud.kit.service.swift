//
//  cloud.kit.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 18/08/2022.
//

import Foundation
import CloudKit

class CloudKitService {
    

    static var icloudAccountUUID = ""

    static let defaultStore = NSUbiquitousKeyValueStore()
    
    struct keys {
        static let ANONYMOUS_ICLOUD_ID: String = "ANONYMOUS_ICLOUD_ID"
    }

    
    static func userRecordId(completion: @escaping(String?) -> ()) -> Void {
//        return await withCheckedContinuation { continuation in
//            var idString: String? = nil
            let container = CKContainer.default()
            container.fetchUserRecordID() { id, error in
                if let isError = error {
                    print("error: \(isError)")
                    print("this device seems to not have any icloud account configured")
                }
                if let testId = id?.recordName {
//                    idString = testId
                    completion(testId)
                } else {
                    completion(nil)
                }
//                continuation.resume(returning: idString)
//                completion(idString)
            }
//        }
    }
    

    
    
//    static func registeriOSAccount() async {
//        let appVendorIdentifier =  DeviceService.getAppIdentifier()
//        let iCloudUserRecordId = await CloudKitService.userRecordId()
//    
//        
//        let parameters = AddiCloudParameters(
//            userRecordId: iCloudUserRecordId ?? "",
//            appIdentifier: appVendorIdentifier
//        )
//        print(parameters)
//        AddiCloudAccountAPICall().registeriCloud(param: parameters) { message, addiCloudAccountResponse in
//            print("response of add icloud account = \(String(describing: addiCloudAccountResponse))")
//            CloudKitService.icloudAccountUUID = addiCloudAccountResponse?.uuid ?? ""
//            UtilityMethod().saveInDefault(value: CloudKitService.icloudAccountUUID, key: ConstantOfApp.kIcloudAccountUUID)
//        }
//    }
    
    static func getDetailOfiCloud() async{
        GetiCloudDetailAPICall().getiCloudDetail { message, icloudDetailResponse in
            print("response of icloud account details is = \(String(describing: icloudDetailResponse))")
        }
    }
    
    static func getiCloudAccountUUID()->String{
        return UtilityMethod().getValueForKey(key: ConstantOfApp.kIcloudAccountUUID) as? String ?? ""
    }
    
    
    

    static func getAnonymousIcloudId() -> String {
            let id: String? = CloudKitService.defaultStore.string(forKey: CloudKitService.keys.ANONYMOUS_ICLOUD_ID)
            
            if let safeId = id {
                return safeId
            }
            
            CloudKitService.setAnonymousICloudId()
            return CloudKitService.getAnonymousIcloudId()
        }
        
        static func setAnonymousICloudId() -> Void {
            let id: String = NSUUID().uuidString
            CloudKitService.defaultStore.set(id, forKey: CloudKitService.keys.ANONYMOUS_ICLOUD_ID)
        }

}
