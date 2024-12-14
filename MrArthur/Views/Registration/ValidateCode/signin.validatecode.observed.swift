//
//  SignInValidationCodeView+Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import Foundation
extension SignInValidationCodeView{
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
                    withToken: ConstantOfApp.kNoneTokenSend,
                    param: param
                ) { (errormessage ,statusOfAPI) in
                    DispatchQueue.main.async {
                        onCompletion(statusOfAPI,errormessage ?? "")
                    }
                }
            }
        }
    }
}
