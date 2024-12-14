//
//  OnbordingStepApiCall.swift
//  MrArthur
//
//  Created by IPS-169 on 13/07/22.
//

import Foundation

struct OnbordingNextStepRequest: Codable {
    var subscriptionUUID: String?
    var stepName: String?
}

struct OnbordingStepAPICall{
    func apiCall(
        parameter: OnbordingNextStepRequest,
        completion: @escaping(String?, OnbordingResponseModel?) -> ()
    ) {
        let parameters: [String: Any] = (try? parameter.asDictionary()) ?? [:]
        
        APIHelper.shared.callAPI(
            URLString: String(format: "\(ConstantHttp.onboardingExplanationURL)"),
            methodName: .post,
            param: parameters,
            withToken: ConstantOfApp.kObserverTokenSend
            
        ) { data in
            do {
                let launchResponseObj : OnbordingResponseModel = try APIHelper.shared.decodeStickers(from: data)
                completion(nil, launchResponseObj)
            } catch (let error) {
                completion(error.localizedDescription, nil)
            }
        } fail: { error in
            print("error is = \(error) for onboarding api call")
            completion(error, nil)
        }
    }
    
    func attendeeOnboardingAPICall(
        parameter: [String:Any],
        completion: @escaping (String?, OnbordingResponseModel?) -> ()
    ) {
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.attendeeOnboardingExplanationURL,
            methodName: .post,
            param: parameter,
            withToken: ConstantOfApp.kAttendeeTokenSend
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
}

