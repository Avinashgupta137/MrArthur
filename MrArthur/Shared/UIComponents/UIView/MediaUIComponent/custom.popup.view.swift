//
//  custom.popup.view.swift
//  MrArthur
//
//  Created by trootech on 07/10/22.
//

import SwiftUI

struct CustomPopupView<Content, PopupView>: View where Content: View, PopupView: View {
    
    @Binding var isPresented: Bool
    @ViewBuilder let content: () -> Content
    @ViewBuilder let popupView: () -> PopupView
    let backgroundColor: Color
    let animation: Animation?
    
    var body: some View {
        
        content()
            .animation(nil, value: isPresented)
            .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
            .overlay(isPresented ? popupView() : nil)
            .animation(animation, value: isPresented)
    }
}

extension View {
    func customPopupView<PopupView>(
        isPresented: Binding<Bool>,
        popupView: @escaping () -> PopupView,
        backgroundColor: Color = .black.opacity(0.7),
        animation: Animation? = .default
    ) -> some View where PopupView: View {
        return CustomPopupView(
            isPresented: isPresented,
            content: { self },
            popupView: popupView,
            backgroundColor: backgroundColor,
            animation: animation
        )
    }
}
