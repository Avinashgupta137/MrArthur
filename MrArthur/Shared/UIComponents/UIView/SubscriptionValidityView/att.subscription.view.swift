//
//  att.subscription.view.swift
//  MrArthur
//
//  Created by BAPS on 23/01/23.
//

import SwiftUI

struct ATTSubscriptionView: View {
    var body: some View {
        VStack {
            Spacer()
            SubscriptionCardView {
                VStack(spacing: 30.h) {
                    Text("YOUR SUBSCRIPTION ENDED".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                        .padding(.top, 92.h)
                    
                    Text("Congratulations, you've done a great job so far!".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    
                    Text("To be able to continue your efforts and improve your knowledge, your parents must now take out a subscription.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                        .padding(.bottom, 53.h)
                    
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16.w)
        .fullScreenFrame
        .background(
            Color.white
                .opacity(0.8)
                .blur(radius: 10)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
