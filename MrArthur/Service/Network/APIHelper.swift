//
//  APIHelper.swift
//  Mr Arthur
//
//  Created by IPS-169 on 06/07/22.
//

import Foundation

class APIHelper {
    
    public static let shared = APIHelper()
    
    static func dataToJSON(data: Data) -> Any? {
        if data.count == 0 {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func decodeStickers<T: Decodable>(from data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func decodeDataToModel<T: Decodable>(from data: Data) throws -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            print("JSONDecoder FAIL: ", error.localizedDescription)
            return nil
        }
    }
    
    func callAPI(
        URLString: String,
        methodName: APICallMethodType,
        param: [String: Any]? = nil,
        withToken: String,
        widgetApiCall: Bool = false,
        success: @escaping ((Data) -> Void),
        fail: @escaping ((String) -> Void)
    ) {
        
        let url = URL.init(string: URLString)
        guard let urlObj = url else {
            let errorMsg = "Please provide valid url"
            self.failureCallback(message: errorMsg, fail: fail)
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest.init(url: urlObj)
        let userToken = UtilityMethod().getValueForKey(key: ConstantOfApp.kObserverUserToken) as? String ?? ""
        let attendeeUserToken = UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUserToken) as? String ?? ""
        print("url is = \(URLString) and with token is = \(withToken) attendee  token value is = \(attendeeUserToken)")
        if widgetApiCall {
            if let token = ExtensionWidgetDataSource.getObserverToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        } else {
            if (withToken == ConstantOfApp.kNoneTokenSend) {
            } else if (withToken == ConstantOfApp.kObserverTokenSend) {
                print("usertoken is = \(userToken)")
                request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
            } else if (withToken == ConstantOfApp.kAttendeeTokenSend) {
                print("usertoken is = \(attendeeUserToken)")
                request.setValue("Bearer \(attendeeUserToken)", forHTTPHeaderField: "Authorization")
            } else {
                request.setValue("Bearer \(withToken)", forHTTPHeaderField: "Authorization")
            }
        }
        
        
        if (methodName == APICallMethodType.get) {
            request.httpMethod = "GET"
        } else if (methodName == APICallMethodType.put) {
            request.httpMethod = "PUT"
            if let params = param {
                do {
                    print(params)
                    let parameterData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    let json = NSString(data: parameterData, encoding: String.Encoding.utf8.rawValue)
                    if let json = json {
                        print("HTTP Body")
                        print(json)
                    }
                    request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        } else if (methodName == APICallMethodType.patch) {
            request.httpMethod = "PATCH"
            if let params = param {
                do {
                    print(params)
                    let parameterData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    let json = NSString(data: parameterData, encoding: String.Encoding.utf8.rawValue)
                    if let json = json {
                        print("HTTP Body")
                        print(json)
                    }
                    request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                } catch {
                    
                    print(error.localizedDescription)
                    return
                }
            }
        } else if (methodName == APICallMethodType.post) {
            request.httpMethod = "POST"
            if let params = param {
                do {
                    print(params)
                    let parameterData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    let json = NSString(data: parameterData, encoding: String.Encoding.utf8.rawValue)
                    if let json = json {
                        print("HTTP Body")
                        print(json)
                    }
                    request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                } catch {
                    
                    print(error.localizedDescription)
                    return
                }
            }
        }
        else if (methodName == APICallMethodType.delete) {
            request.httpMethod = "DELETE"
            if let params = param {
                do {
                    print(params)
                    let parameterData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    let json = NSString(data: parameterData, encoding: String.Encoding.utf8.rawValue)
                    if let json = json {
                        print("HTTP Body")
                        print(json)
                    }
                    request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                } catch {
                    
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if (Reachability.isConnectedToNetwork()) {
            let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { rData, response, error in
//                print("------Api Response-------")
//                debugPrint(response)
//                print("------Api Response-------")
                guard error == nil else {
                    print("error in api call is = \(String(describing: error?.localizedDescription))")
                    let errorMsg = error?.localizedDescription ?? "some thing went wrong"
                    self.failureCallback(message: errorMsg, fail: fail)
                    return
                }
                guard let data = rData else {
                    print("response is = \(String(describing: response)) but data is not coming")
                    let errorMsg = "Response data not found"
                    self.failureCallback(message: errorMsg, fail: fail)
                    return
                }
                if let urlresponse = response as? HTTPURLResponse, data.count > 0 {
                    if (urlresponse.statusCode == 200 || urlresponse.statusCode == 201) {
                        print("response = \(String(describing: APIHelper.dataToJSON(data: data)))")
                        DispatchQueue.main.async {
                            success(data)
                        }
                        if let err = error {
                            let errorMsg = err.localizedDescription
                            self.failureCallback(message: errorMsg, fail: fail)
                        }
                    } else {
                        let errordic = APIHelper.dataToJSON(data: data )
                        print("error dic is = \(String(describing: errordic))")
                        let jsondata = APIHelper.dataToJSON(data: data )
                        print("json data is = \(String(describing: jsondata))")
                        if let errorresponse: ErrorResponseModel = try? APIHelper.shared.decodeStickers(from: data ) {
                            if ((errorresponse.message?.count ?? 0) > 0) {
                                let errorMsg = errorresponse.message?.first ?? ""
                                self.failureCallback(message: errorMsg, fail: fail)
                            }
                        } else {
                            var errorMsg = "Something went wrong"
                            switch (urlresponse.statusCode) {
                            case 403:
                                errorMsg = "OBSERVER_USER_HAS_NO_RIGHT_ON_SUBSCRIPTION"
                            case 404:
                                errorMsg = "Url not found"
                            case 401:
                                errorMsg = "Unauthorized"
                            case 500...509:
                                errorMsg = "Internal server error"
                            case 400:
                                errorMsg = "Bad request"
                            default:
                                errorMsg = "Cannot get any error"
                            }
                            self.failureCallback(message: errorMsg, fail: fail)
                        }
                    }
                }else{
                    success(data)
                }
            }
            
            task.resume()
        } else {
            let errorMsg = "No active internet connection,please check your connection"
            self.failureCallback(message: errorMsg, fail: fail)
        }
    }
    
    static func stringArrayToData(stringArray: [[String: Any]]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }
    
    private func failureCallback(
        message: String,
        fail: @escaping ((String) -> Void)) {
            DispatchQueue.main.async {
                if currentScheme == .DEVELOPEMENT {
#if UIApplication
                    AppShared.customShowAlert(message: message)
#endif
                }
                fail(message)
            }
        }
}

protocol MyEncodable: Encodable {
    func toJSONData() -> Data?
}

extension Encodable {
    func toJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

