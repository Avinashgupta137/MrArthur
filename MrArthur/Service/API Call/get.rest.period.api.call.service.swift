//
//  get.rest.period.api.call.service.swift
//  MrArthur
//
//  Created by IPS-169 on 13/09/22.
//

import Foundation
struct GetRestPeriodAPICall{
    func getRestPeriod(
        completion: @escaping (String?, ICloudDetailResponse?) -> ()
    ) {
        let parameters: [String: Any] =  [String:Any]()
        let attendeeUDID =  UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? ""
        let strParentSettingURL = "\(attendeeUDID)/parental-control-settings/rest-period"
        if let token = CurrentUserService.getToken() {
            APIHelper().callAPI(
                URLString: ConstantHttp.getRestPeriodURL + strParentSettingURL,
                methodName: .get,
                param: parameters,
                withToken: token
            ) { data in
                if let resData: ICloudDetailResponse = try? APIHelper.shared.decodeStickers(from: data) {
                    completion("", resData)
                } else {
                    completion("Can not decode the model", nil)
                }
            } fail: { errorMessage in
                completion(errorMessage, nil)
            }
        }
    }
}
