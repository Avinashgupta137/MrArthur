//
//  observer.addup.privacy.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 06/09/22.
//

import Foundation
import SwiftUI
extension ObserverAddupPrivacyView {
    class Observed: ObservableObject {
        func fetchLaunchResponse(completion: @escaping (String?, Bool) -> ()) {
            FirstLaunchAPICall.request { errorMsg, response  in
                completion(errorMsg, response != nil)
            }
        }
    }
}
