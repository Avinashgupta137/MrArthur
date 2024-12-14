//
//  tabbar.view.swift
//  MrArthur
//
//  Created by BAPS on 23/01/23.
//

import SwiftUI

struct TabbarView: View {
    @Binding var tabPage: ETabPage
    let onMessage: () -> ()
    var body: some View {
        HStack(spacing: 0) {
            TabBarItem(
                iconName: "TabsMenuDashboard\((tabPage == .page_01) ? "On" : "Off")Icon",
                label: "Dashboard",
                page: .page_01,
                selected: $tabPage
            )
            Spacer(minLength: 10.w)
            Button(action: onMessage) {
                VStack(alignment: .center, spacing: 5){
                    Image("TabsMenuMessageOffIcon")
                        .scaledToFit()
                        .frame(minWidth: 25.r, minHeight: 25.r)
                    Text("Message".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: 12.sp,
                            color: .lightPink
                        )
                    Spacer(minLength: 5.h)
                }
            }
            .padding(.top, 16.h)
            .foregroundColor(Color.primaryRed)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            Spacer(minLength: 10.w)
            TabBarItem(
                iconName: "TabsMenuApps\((tabPage == .page_02) ? "On" : "Off")Icon",
                label: "Apps",
                page: .page_02,
                selected: $tabPage
            )
            Spacer(minLength: 10.w)
            TabBarItem(
                iconName: "TabsMenuMedias\((tabPage == .page_03) ? "On" : "Off")Icon",
                label: "Medias",
                page: .page_03,
                selected: $tabPage
            )
            Spacer(minLength: 10.w)
            TabBarItem(
                iconName: "TabsMenuPlus\((tabPage == .page_04) ? "On" : "Off")Icon",
                label: "More",
                page: .page_04,
                selected: $tabPage
            )
        }
        .frame(height: 101.h)
    }
}
