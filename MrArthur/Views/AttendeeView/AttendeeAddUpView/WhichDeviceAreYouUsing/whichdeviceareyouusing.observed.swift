//
//  WhichDeviceAreYouUsing + Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 26/07/22.
//

import Foundation
import SwiftUI

extension WhichDeviceAreYouUsing{
    class WhichDeviceAreYouUsingObserver: ObservableObject{
        
        @EnvironmentObject private var rootViewObserver: RootViewObserver
        func showParentDashboard(
            completion: @escaping(String?, Bool, [AttendeeListResponseModel]) -> ()
        ) {
            let attendeeListRequest = AttendeeListRequestModel.init(
                subscriptionUUID: UtilityMethod().getValueForKey(
                    key: ConstantOfApp.kUUIDForSubscription
                ) as? String ?? ""
            )
            if let param = try? attendeeListRequest.asDictionary(){
                AttendeeListAPICall().attendeeListapiCall(parameter: param) { err, attendeeListResponse in
                    DispatchQueue.main.async{
                        if let error = err, !error.isEmpty {
                            completion(error,false,[])
                        } else {
                            if let list = attendeeListResponse, list.count > 0 {
                                completion("",true,list)
                            } else {
                                completion("Add child",false,[])
                            }
                        }
                    }
                }
            }
        }
        
        func attendeeLogin(completion:@escaping(Bool,String?,AttendeeLoginResponseModel,(Any))->()){
            UserDefaultsHelper.appUserType = .attendee
            let param = [String:Any]()
            LoginHelper().attendeeLoginAPICall(param: param) { value in
                print("Redirect to \(value)")
                if let data = value as? (manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
                    if(data.rootScreen == .attendeeDashboard){
                        MediationService().getMediation { errmsg, mediationDetailResponse,statusOfAPICall  in
                            let statusOfMediation = UtilityMethod().getValueForKey(key: ConstantOfApp.kStatusOfMeditation) as? String ?? ""
                            if(statusOfMediation == ConstantOfApp.kMediationNotCreated){
                                self.rootViewObserver.currentPage = .attendeeDashboard
                            }else{
                                self.rootViewObserver.currentPage = .attendeeTabBar
                            }
                        }
                    }else{
                        self.rootViewObserver.currentPage = data.rootScreen
                    }
                }else if let data = value as? ERootView{
                    print("else Redirect to \(value)")
                    self.rootViewObserver.currentPage = data
                }
            } failure: { errmsg in
                
            }
        }
    }
}
