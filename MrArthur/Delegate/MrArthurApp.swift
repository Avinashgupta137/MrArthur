//
//  MrArthurApp.swift
//  MrArthur
//
//  Created by IPS-157 on 06/07/22.
//

import SwiftUI

@main
struct MrArthurApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
//    @StateObject var appSelectionObserved = AppSelectionObserved.shared
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(RootViewObserver())
                .environmentObject(LoaderObserver())
                .environmentObject(TabViewRouter())
                .environmentObject(AddUpEstimate())
                .environmentObject(AttendeeHowItWorkPageObs())
                .environmentObject(ObserverManifesto(index: UserDefaultsHelper.latestStep ?? 0))
                .environmentObject(AttendeeManifestoObserver(index: UserDefaultsHelper.attendeeManifestoLatestStep ?? 0))
                .onReceive(NotificationCenter.default.publisher(
                    for: UIApplication.didBecomeActiveNotification
                )) { (_) in
                }
//                .onOpenURL { url in
//                    dump("onOpenURL: \(url)")
//                    let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
//                    if let components = components {
//                        if let path = components.path, let params = components.queryItems {
//                            dump("PATH: \(path)")
//                            dump("Params: \(params)")
//                        }
//                    }
//                    dump(components)
//                }
        }
    }
}
