//
//  ObserverDashboardView.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//

import SwiftUI

struct ObserverDashboardView: View {
    @ObservedObject var appState = AppState.shared
    var body: some View {
        NavigationView{
            Group {
                if UserDefaultsHelper.observerCanAccessToAttendeeSceenTimeDashboard() {
                    SubscriptionContentView {
                        ObserverScreenTimeDashboardView()
                    }
                } else {
                    ObserverMideationDashboardView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

