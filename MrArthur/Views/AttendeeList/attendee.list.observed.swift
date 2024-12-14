//
//  attendee.list.observed.swift
//  MrArthur
//
//  Created by IPS-169 on 06/09/22.
//

import Foundation
import SwiftUI
extension AttendeeListView{
    class Observed:ObservableObject{
        @Published var arrOfAttendee: [AttendeeListResponseModel] = []
        
        init() {
            getListFromLocal { error, list in
                if error == nil {
                    self.arrOfAttendee = list
                }
                self.getAttendeeList { error, list in
                    if error == nil {
                        self.arrOfAttendee = list
                    }
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
        
        func getMediation(compeletion:@escaping(Bool,String)->()){
            MediationService().getMediation { errormsg, meditationResponse,status  in
                compeletion(status,errormsg)
                print(errormsg)
            }
        }
        func attendeeLogin(
            attendee: AttendeeListResponseModel,
            completion:@escaping(ERootView)->()
        ) {
            let mediation = attendee.attendeeUserMediationList?.first
            UtilityMethod()
                .saveInDefault(
                    value: mediation?.uuid ?? "",
                    key: ConstantOfApp.kMediationUDID
                )
            print("mediation uuid = \(UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID))")
            UtilityMethod()
                .saveInDefault(
                    value: attendee.uuid ?? "nouuid",
                    key: ConstantOfApp.kAttendeeUUID
                )
            
            UserDefaultsHelper.appUserType = .attendee
            let param = [String:Any]()
            LoginHelper().attendeeLoginAPICall(param: param) { value in
                print("Redirect to \(value)")
                if let data = value as? (manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
                    if(data.rootScreen == .attendeeDashboard){
                        MediationService().getMediation { errmsg, mediationDetailResponse,statusOfAPICall  in
                            
                           
                            let statusOfMediation = UtilityMethod().getValueForKey(key: ConstantOfApp.kStatusOfMeditation) as? String ?? ""
                            if(statusOfMediation == ConstantOfApp.kMediationNotCreated){
                                completion(.attendeeDashboard)
                            }else{
                                MediationService().fetchMediationInfo { message, MediationDetailResponseModel, status in
                                         if(status == true){
                                           
                                         }
                                     }
                                completion(.attendeeTabBar)
                            }
                        }
                    } else {
                        completion(data.rootScreen)
                    }
                }else if let data = value as? ERootView{
                    print("else Redirect to \(value)")
                    completion(data)
                }
            } failure: { errmsg in
                print("failure \(errmsg)")
            }
        }
        
        private func getListFromLocal(completion:@escaping(String?, [AttendeeListResponseModel])->()) {
            if let localData = UserDefaultsHelper.currentUserAttenseeListData {
                if let list : [AttendeeListResponseModel] = try? APIHelper.shared.decodeDataToModel(from: localData){
                    completion(nil,list)
                } else {
                    completion("Can not decode the model",[])
                }
            } else {
                completion("Local data not found",[])
            }
        }
    }
}
