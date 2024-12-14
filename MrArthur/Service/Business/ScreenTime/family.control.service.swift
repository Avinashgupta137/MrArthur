//
//  screen.time.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 31/08/2022.
//

import Foundation
import FamilyControls
import ManagedSettings

class FamilyControlService {
    public static var errorMessage = ""
    public static func AuthorizationSet(completion: @escaping(Bool, String, Int?)->()){
        Task{
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .child)
                completion(true, "",nil)
            } catch {
                print("Screen Time error:\(error)")
                let error = error as NSError
                if (error.domain == "FamilyControls.FamilyControlsError") {
                    switch (error.code) {
                    case 0:
                        //We required Popup message to display the message to user
                        // - with 2 button (Cancel - Device Settings)
                        print("A restriction prevents your app from using Family Controls on this device.")
                    case 1:
                        //We required Popup message to display the message to user
                        // - with 2 button (Cancel & Information) Information to fix the error
                        print("The system failed to set up the Family Control framework.")
                    case 2:
                        //We required Popup message to display the message to user
                        // - with 2 button (Cancel & Device Settings)
                        print("The device isn't signed into a valid iCloud account.")
                    case 3:
                        errorMessage = "The method's arguments are invalid."
                        print("The method's arguments are invalid.")
                    case 4:
                        //We required Popup message to display the message to user
                        // - with 2 button (Cancel & Device Settings)
                        print("Another authorized app already provides parental controls.")
                    case 5:
                        print("The observer or attendee canceled a request for authorization.")
                    case 6:
                        //We required Popup message to display the Internet Contivity error to user
                        // - with 2 button (Ok)
                        print("Internet Connitivity Error")
                    default:
                        //We required default popup message to display the message to user
                        // - with 2 button (Cancel & Ok)
                        print("Unable to authorise Family Controls")
                    }
                    completion(false, "\(errorMessage)", error.code)
                }
            }
        }
    }
    public static func revokeAuthorization() {
        AuthorizationCenter.shared.revokeAuthorization { result in
            print("Authorization Revoke")
        }
    }
}
