//
//  obs.subscription.view.swift
//  MrArthur
//
//  Created by BAPS on 23/01/23.
//

import SwiftUI

struct OBSSubscriptionView: View {
    let subscribe: () -> ()
    var body: some View {
        VStack {
            Spacer()
            SubscriptionCardView {
                VStack(spacing: 30.h) {
                    Text("YOUR SUBSCRIPTION ENDED".localized.uppercased())
                        .fontModifier(
                            font: .montserratBlack,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                        .padding(.top, 92.h)
                    
                    Text("Your child has made progress in setting goals with you and learning on engaging apps.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    
                    Text("To continue using our app,".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    +
                    Text(" please choose the paying plan that best fits your needs and budget.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    
                    Text("Thank you for choosing us, we look forward to helping you and your children reach their goals.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: 18.sp,
                            color: .primaryBlue
                        )
                    
                    BlueRoundedButton(
                        "CONTINUE",
                        action: subscribe
                    )
                    .padding(.bottom, 57.h)
                    .padding(.top, 66.h)
                }
            }
            Spacer()
        }
        .background(
            Color.clear
                .edgesIgnoringSafeArea(.all)
        )
    }
}


struct SubscriptionValidityView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .center) {
            Color.primaryYellow
            OBSSubscriptionView(subscribe: {})
        }
        .edgesIgnoringSafeArea(.all)
    }
}
