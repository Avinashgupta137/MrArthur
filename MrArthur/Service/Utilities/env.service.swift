//
// Created by Reille Sebastien on 19/08/2022.
//

import Foundation
import Swift

struct Env: Decodable {
    var apiBaseUrl: String
}


class EnvService {
    static let shared: EnvService = EnvService()
    public var env: Env? = nil

    public static func apiBaseUrl() -> String? {
        let apiBaseUrl: String? = EnvService.getEnv()?.apiBaseUrl
        print("API_BASE_URL from env: ")
        dump(apiBaseUrl)
        dump(EnvService.getEnv()?.apiBaseUrl)

        if let _ = apiBaseUrl, apiBaseUrl != "" {
            return apiBaseUrl
        } else {
            return nil
        }
    }

    public static func getEnv() -> Env? {
        if (EnvService.shared.env == nil) {
            EnvService.shared.env = EnvService.loadJson()
        }
        return EnvService.shared.env
    }

    public static func loadJson() -> Env? {
        if let url = Bundle.main.url(forResource: "env", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Env.self, from: data)
                return jsonData
            } catch {
                print("[EnvService][loadJson] error while loading env.json:\(error)")
            }
        }
        return nil
    }
}