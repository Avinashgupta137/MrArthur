//
//  user.login.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 19/01/2023.
//

import Foundation

class UserLoginService {
    static func getValidationCodeFromOpenUrl(url: URL) -> String? {
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        var code: String? = nil
        if let components = components {
            if let path = components.path, let params = components.queryItems, let scheme = components.scheme {
                dump("PATH: \(path)")
//                dump("Params: \(params)")
                if scheme == "mrarthurautologin" && path == "/autoLogin" {
                    if let parameterCode = params.first(where: { $0.name == "code" })?.value {
                        code = parameterCode
                    }
                }
            }
        }
        return code
    }
}
