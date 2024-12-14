//
//  SignInValidationCodeView+Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import Foundation
import Intercom
extension SignUpValidationCodeView{
    class Observed:ObservableObject{
        func didNotReceivePin(onCompletion:@escaping (Bool,String) -> () ){
            let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
            let userlang = DeviceService.getDeviceLanguage()
            let loginRequest = LoginRequestModel.init(
                email: email,
                language: userlang
            )
            if let param = try? loginRequest.asDictionary(){
                LoginHelper.loginAPICall(
                    withToken: ConstantOfApp.kObserverTokenSend,
                    param: param
                ) { (errormessage ,statusOfAPI) in
                    onCompletion(statusOfAPI,errormessage ?? "")
                    
                }
            }
        }
    }
}


