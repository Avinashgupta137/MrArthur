//
//  InfoDisplayView.swift
//  MrArthur
//
//  Created by IPS-169 on 27/07/22.
//

import SwiftUI



struct InfoDisplayView<Content: View>: View {
    private let iconSize: CGFloat = 35.r
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(systemName: "info")
                .font(.system(size: 25.r, weight: .bold))
                .foregroundColor(Color.white)
                .frame(width: iconSize, height: iconSize)
                .background(Color.primaryBlue.cornerRadius(iconSize/2))
                .zIndex(1)
            HStack {
                Spacer(minLength: 24.w)
                content
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 32.h)
                Spacer(minLength: 24.w)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 35.resizable)
                    .stroke(Color.primaryBlue, lineWidth: 1)
            )
            .padding(.top, iconSize/2)
            .padding(.horizontal, 24.w)
            .zIndex(0)
        }
    }
}
