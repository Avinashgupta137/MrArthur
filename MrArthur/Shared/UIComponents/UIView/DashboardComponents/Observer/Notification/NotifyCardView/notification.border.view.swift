//
//  notification.border.view.swift
//  MrArthur
//
//  Created by trootech on 14/09/22.
//

import SwiftUI

struct NotificationBorderView<Content: View>: View {
    
    let content: Content
    let color: Color
    
    init(color: Color, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.color = color
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Circle()
                .fill(color)
                .frame(width: 17.r, height: 17.r)
                .overlay(
                    Circle()
                        .stroke(Color.secondaryRed, lineWidth: 5.r)
                )
                .zIndex(1)

            content
                .padding(.vertical, 14.h)
            .background(
                Color.secondaryRed
                    .cornerRadius(24.r)
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: 24.r
                )
                .stroke(color, lineWidth: 3.w)
            )
        }
    }
}
