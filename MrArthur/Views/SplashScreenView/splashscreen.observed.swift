//
//  SplashScreenView+Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 18/07/22.
//

import SwiftUI


enum ERootView: String {
    case welcome, observerManifesto, signUp, observerTabBar, returnOBSTabBar, returnOBSManifesto
    case  observerQuestionPerfectWellDone, addAttende, whichDeviceUsing, mediationApproved
    case attendeeList ,attendeePariningSetup, gainDataView
    case attendeeManifesto, attendeeQuestionPerfectWellDone, attendeeTabBar, attendeeDashboard, addUpNotificationView, attendeeHowItsWorkValidation, returnATTTabBar
}

class RootViewObserver:ObservableObject{
    @ObservedObject var appState = AppState.shared
    @Published var currentPage: ERootView
    
    init(initpage: ERootView = .welcome) {
        self.currentPage = initpage
    }
}

class ObservedSplash:ObservableObject{
    func getUserType()->AppIsUsedBy{
        if let appisUsedBy = UtilityMethod().getValueForKey(key: ConstantOfApp.kIdentifiedUser) as? String{
            if(appisUsedBy == "attendee"){
                return   AppIsUsedBy.attendee
            }else{
                return AppIsUsedBy.observer
            }
        }else{
            print(UtilityMethod().getValueForKey(key: ConstantOfApp.kIdentifiedUser))
            return AppIsUsedBy.observer
        }
    }
}
