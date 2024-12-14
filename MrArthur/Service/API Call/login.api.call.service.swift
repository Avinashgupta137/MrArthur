//
//  LoginAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import Foundation
struct LoginAPICall{
    func request(parameter:[String:Any],completion:@escaping(String, Bool)->()){
        APIHelper.shared.callAPI(
            URLString: String.init(format: "\(ConstantHttp.observerLoginURL)"),
            methodName: .post,
            param: parameter,
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
           
            completion("", true)
        } fail: { error in
            completion(error, false)
        }
    }
}
