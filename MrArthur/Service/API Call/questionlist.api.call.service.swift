//
//  QuestionListAPICall.swift
//  MrArthur
//
//  Created by IPS-169 on 14/07/22.
//

import Foundation


struct QuestionListAPICall{
    
    
    var arrOfScreenName = [String]()
   
    func request(
        parameter: [String:Any],
        completion: @escaping(String?, OnbordingResponseModel?) -> ()
    ) {
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.observerQuestionListURL,
            methodName: .post,
            param: parameter,
            withToken: ConstantOfApp.kObserverTokenSend
        ) { data in
            if let model : OnbordingResponseModel = try? APIHelper.shared.decodeStickers(from: data){
                completion(nil, model)
            } else {
                completion("Can not decode the model", nil)
            }
        } fail: { error in
            print("error is = \(error) for onboarding api call")
            completion(error, nil)
        }
    }
    
    func attendeeAnsweredAPICall(
        parameter: [String:Any]?,
        completion: @escaping(String?, OnbordingResponseModel?) ->()
    ) {
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.attendeeQuestionListURL.trimmingCharacters(in: Foundation.CharacterSet.whitespaces),
            methodName: .post,
            param: parameter,
            withToken: ConstantOfApp.kAttendeeTokenSend
        ) { data in
            if let model : OnbordingResponseModel = try? APIHelper.shared.decodeStickers(from: data){
                completion(nil, model)
            }else{
                completion("Can not decode the model", nil)
            }
        } fail: { error in
            print("error is = \(error) for onboarding api call")
            completion(error, nil)
        }
       
    }
}

