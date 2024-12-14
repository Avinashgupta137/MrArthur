//
//  CustomTabBarItem.swift
//  SwiftUICustomTabBar
//
//  Created by IPS-157 on 26/07/22.
//

import SwiftUI

struct TabBarItem: View {
    let iconName: String
    let label: String
    let page: ETabPage
    @Binding var selected: ETabPage
    
    var body: some View {
        VStack(alignment: .center) {
            Image(iconName)
                .scaledToFit()
                .frame(minWidth: 25.r, minHeight: 25.r)
            Text(label.localized)
                .fontModifier(
                    font: .montserratBold,
                    size: 12.sp,
                    color: fgColor()
                )
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 10.h)
        }
        .padding(.top, 16.h)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            self.selected = self.page
        }
    }
    
    private func fgColor() -> Color {
        return selected == self.page ? Color.primaryRed : Color.lightPink
    }
}
