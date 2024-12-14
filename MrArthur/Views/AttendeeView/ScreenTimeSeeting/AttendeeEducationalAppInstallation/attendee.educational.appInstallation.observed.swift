//
//  attendee_educational_appInstallation.observed.swift
//  MrArthur
//
//  Created by IPS-157 on 30/08/22.
//


import Foundation
import SwiftUI

extension AttendeeEducationalAppInstallationView{
    class ObservedEducation:ObservableObject{
        
        @Published var arrOfRecommandedAppData: [RecommandedAppListResponseModel] = []
        @Published var arrOfInstallAppList: [InstallAppResponseModel] = []
        
        func getRecommendedAppList() {
            RecommededAppService.getList { status, message, recommendedAppList in
                self.arrOfRecommandedAppData = recommendedAppList
                self.getInstalledApplist()
            }
        }
        
        func getInstalledApplist() {
            RecommededInstallAppService.getList { status, message, installAppList in
                self.arrOfInstallAppList = installAppList
            }
        }
        
        func addInstalledApp(appUdid: String) {
            RecommededInstallAppService.addList(appUdid: appUdid) { Status, message, installAppList in
                self.getInstalledApplist()
            }
        }
        
        func seeOnAppStore(appUrl: String) {
            if let url = URL(string: appUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        func shareApp(appUrl: String, appUDID: String) {
            guard let urlShare = URL(string: appUrl) else { return }
            addInstalledApp(appUdid: appUDID)
            AppShared.shareSheet(items: [urlShare])
        }
        
        func installApp(appUrl: String, appUDID: String) {
            if let url = URL(string: appUrl), UIApplication.shared.canOpenURL(url) {
                addInstalledApp(appUdid: appUDID)
                UIApplication.shared.open(url)
            }
        }
        
        func isAppInstalled(appUUID: String) -> Bool {
            return arrOfInstallAppList.contains(where: {$0.uuid == appUUID})
        }
    }
}
