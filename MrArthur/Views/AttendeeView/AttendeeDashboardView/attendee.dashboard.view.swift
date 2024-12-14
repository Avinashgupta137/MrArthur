//
//  AttendeeDashboardView.swift
//  MrArthur
//
//  Created by Troo on 01/08/22.
//


import SwiftUI

struct AttendeeDashboardView: View {
    @State var manifestoCompleted = UserDefaultsHelper.selectedAttendee?.mediationCompleted ?? false
    var body: some View {
        NavigationView{
            Group {
                if !manifestoCompleted {
                    AttendeeMideationDashboardView(manifestoCompleted: $manifestoCompleted)
                } else {
                    SubscriptionContentView(forOBS: false) {
                        AttendeeScreenTimeDashboardView()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
