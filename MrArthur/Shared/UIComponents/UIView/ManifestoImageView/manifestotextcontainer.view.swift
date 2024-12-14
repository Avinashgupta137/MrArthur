//
//  ManifestoTextContainerView.swift
//  MrArthur
//
//  Created by Troo on 28/07/22.
//

import SwiftUI

struct ManifestoTextContainerView<Content: View>: View {
    let content: Content
    let topPadding: CGFloat
    
    init(topPadding: CGFloat = 50, @ViewBuilder content: () -> Content){
        self.content = content()
        self.topPadding = topPadding
    }
    
    var body: some View {
        VStack(spacing: 0) {
            self.content
                .padding(.horizontal, 20.h)
            Spacer()
        }
        .padding(.top, topPadding.h)
        .padding(.horizontal, 16.w)
        .frame(width: UIScreen.screenWidth)
        .background(Color.white)
    }
}
