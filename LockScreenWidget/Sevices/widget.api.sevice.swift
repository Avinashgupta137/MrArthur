//
//  widget.api.sevice.swift
//  MrArthur
//
//  Created by BAPS on 16/01/23.
//

import Foundation
import SwiftUI

class WigetAPIService {
    
    static func getAttendeeScreenTimeTodayData(
        completion: @escaping(GetAttendeeScreenTimeTodayDataResponse?) -> ()
    ) {
        if let attendeeUserUUID = ExtensionWidgetDataSource.getCurrrentAttendeeUUID() {
            let url = ExtensionApiCallService.getApiBaseUrl() + "attendee-user/screen-time/\(attendeeUserUUID)/today-data"
            APIHelper.shared.callAPI(
                URLString: url,
                methodName: .get,
                param: [:],
                withToken: ConstantOfApp.kObserverTokenSend,
                widgetApiCall: true,
                success: { data in
                    if let todayDataResponse: GetAttendeeScreenTimeTodayDataResponse = try? APIHelper.shared.decodeStickers(from: data) {
                        completion(todayDataResponse)
                    } else {
                        completion(nil)
                    }
                },
                fail: { error in
                    completion(nil)
                }
            )
        }
    }
    
    static func getAttendeeByUUID(
        completion:@escaping(String?, AttendeeListResponseModel?)->()
    ) {
        
        if let attendeeUserUUID = ExtensionWidgetDataSource.getCurrrentAttendeeUUID() {
            let url = ConstantHttp.getAttendee + attendeeUserUUID + "/user"
            APIHelper.shared.callAPI(
                URLString: url,
                methodName: .get,
                param: [:],
                withToken: ConstantOfApp.kObserverTokenSend,
                widgetApiCall: true,
                success: { data in
                    if let attendee: AttendeeListResponseModel = try? APIHelper.shared.decodeStickers(from: data) {
                        completion(nil, attendee)
                    } else {
                        completion(ConstantOfApp.kErrorDefaultMessage, nil)
                    }
                },
                fail: { error in
                    completion(error, nil)
                }
            )
        }
    }
    
    static func getDataFromServer(completion: @escaping(
        AttendeeListResponseModel?,
        GetAttendeeScreenTimeTodayDataResponse?
    ) -> Void) {
        self.getAttendeeByUUID { error, attendee in
            self.getAttendeeScreenTimeTodayData { response in
                completion(attendee, response)
            }
        }
    }
}
