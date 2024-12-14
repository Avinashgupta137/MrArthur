//
//  BaseView.swift
//  MrArthur
//
//  Created by Troo on 21/07/22.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    let message: String
    var content: () -> Content
    
    init(message: String = "Loading...", @ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
        self.message = message
    }

    var body: some View {
        LoadingView() {
            self.content()
        }
        .hideNavigation
    }
}
