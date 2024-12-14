//
//  environment.variable.swift
//  MrArthur
//
//  Created by Reille Sebastien on 08/11/2022.
//

import Foundation
enum environmentUrl {
    static var defaultBaseUrl: String = "https://dev.mrarthur.io/"
    static var appBaseURL: String {
//        let isSRDev = true
//        if (isSRDev) {
//#if ENV_DEV
//            return "https://mrarthur.dev/"
//#elseif ENV_STAGE
//            return "https://mrarthur.dev/"
//#elseif ENV_PROD
//            return "https://mrarthur.dev/"
//#endif
//        } else {
        var url = defaultBaseUrl
#if ENV_DEV
        url = "https://dev.mrarthur.io/"
#elseif ENV_STAGE
        url = "https://api.staging.mrarthur.io/"
#elseif ENV_SEBASTIEN
        url = "https://mrarthur.dev/"
#elseif ENV_PROD
        url = "https://api.production.mrarthur.io/"
#endif
//        #endif
//        print("appBaseURL: \(url)")
        ExtensionApiCallService.setApiBaseUrl(url: url)
        return url
    }
}
