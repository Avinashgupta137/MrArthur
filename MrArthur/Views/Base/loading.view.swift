//
//  LoadingView.swift
//  MrArthur
//
//  Created by Troo on 21/07/22.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    var content: () -> Content
    @EnvironmentObject private var observer: LoaderObserver
    
    var body: some View {
        self.content()
            .disabled(self.observer.showLoader)
            .opacity(self.observer.showLoader ? 0.95 : 1)
            .blur(radius: self.observer.showLoader ? 1 : 0)
            
    }
    
}

