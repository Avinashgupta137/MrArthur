//
//  subscription.validity.view.swift
//  MrArthur
//
//  Created by BAPS on 21/12/22.
//

import SwiftUI

struct SubscriptionContentView<Content>: View where Content: View {
    var forOBS: Bool = true
    var content: () -> Content
    @State var showingSheet = false
    @ObservedObject var appState = AppState.shared
    var body: some View {
        ZStack(alignment: .center) {
            self.content()
                .zIndex(appState.hasValidSubscription ? 10 : 0)
                .disabled(!appState.hasValidSubscription)
                .blur(radius: appState.hasValidSubscription ? 0 : 6)
            
            if !appState.hasValidSubscription {
                Group {
                    if forOBS {
                        OBSSubscriptionView(
                            subscribe: {
                                PurshaselyService.shared.start() { success in
                                    if (success) {
                                        self.showingSheet = true
                                    }
                                }
                            }
                        )
                    } else {
                        ATTSubscriptionView()
                    }
                }
                    .zIndex(appState.hasValidSubscription ? 0 : 10)
            }
        }
        .sheet(isPresented: $showingSheet) {
            PurchaselyPaywall(
                placementId: PurshaselyService.getScreenBlockPlacementId()
            ) { success in
                if !isDevelop {
                    appState.hasValidSubscription = success
                } else {
                    appState.hasValidSubscription = true
                }
                showingSheet = false
            }
        }
        .onAppear {
            print("SubscriptionContentView ONAPPEAR")
        }
    }
}

