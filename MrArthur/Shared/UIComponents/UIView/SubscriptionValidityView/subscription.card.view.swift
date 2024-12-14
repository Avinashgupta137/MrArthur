//
//  subscription.card.view.swift
//  MrArthur
//
//  Created by BAPS on 23/01/23.
//

import SwiftUI

struct SubscriptionCardView<Content>: View where Content: View {
    
    var content: () -> Content
    let mrArtherImageSize = CGSize(width: 110.r, height: 110.r)
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("MrArthurIAHappyFace")
                .resizable()
                .frame(width: mrArtherImageSize.width, height: mrArtherImageSize.height)
                .zIndex(1000)
            
            self.content()
                .multilineTextAlignment(.center)
                .padding(.horizontal, 14.w)
                .background(Color.white)
                .cornerRadius(31.r)
                .shadow(radius: 2)
                .padding(.top, mrArtherImageSize.height * 0.5)
            
            
        }
        .padding(.horizontal, 50.w)
    }
}

