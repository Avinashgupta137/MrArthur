//
//  ObserverAccountDetails+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import Foundation
extension ObserverAccountDetails{
    class Observed:ObservableObject{
        @Published  var numberOfChild  = 0
        @Published  var numberOfDevices  = 0
        init(){
            getAttendeeList { message, response in
                print("api called response = \(response)")
                self.numberOfChild =  response.count
                var noOfDevice = 0
                for mediation in response{
                    noOfDevice += mediation.deviceList?.count ?? 0
                    self.numberOfDevices = noOfDevice
                }
            }
        }
        func getAttendeeList(completion:@escaping(String?, [AttendeeListResponseModel])->()){
            let attendeeListRequest = AttendeeListRequestModel(
                subscriptionUUID: UtilityMethod()
                    .getValueForKey(
                        key: ConstantOfApp.kUUIDForSubscription
                    ) as? String ?? ""
            )
            let  param = (try? attendeeListRequest.asDictionary()) ?? [:]
            AttendeeListAPICall().attendeeListapiCall(parameter: param) { error, response in
                DispatchQueue.main.async {
                    if let errMsg = error, !errMsg.isEmpty {
                        completion(error, [])
                    } else {
                        if let list = response {
                            completion(nil, list)
                        } else {
                            completion(ConstantOfApp.kErrorDefaultMessage, [])
                        }
                    }
                }
            }
        }
    }
}
