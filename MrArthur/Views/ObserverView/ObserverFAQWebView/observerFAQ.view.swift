//
//  observerFAQ.view.swift
//  MrArthur
//
//  Created by Nirav Patel on 11/11/22.
//

import SwiftUI

struct observerFAQ: View {
    
    @ObservedObject var webViewModel = CommonWebViewModel(url: "FAQ_URL".localized)
    var body: some View {
        ZStack{
            VStack{
                WebViewContainer(webViewModel: webViewModel)
                if webViewModel.isLoading {
                    ActivityIndicator()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray.opacity(50))
                }
            }
            .customNavigationViewWithBackWidgit(title: "FAQ".localized, color: .whiteColor)
        }
        .fullScreenFrame
    }
}
