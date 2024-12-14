//
//  observer.manifesto.manifesto_mr_arthur_nurse.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoMrarthurNurseView: View {
    let image = "stepOnboardingObserverManifestoMrArthurNurse"
    let height = ScreenUtils.heightByScreenPercent(50) - statusBarHeight
    var body: some View {
        VStack(spacing: 0) {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.top, 52.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: height
                )
                .background(Color.secondaryRed)
                .padding(.top, statusBarHeight)
            
            ManifestoTextContainerView {
                Text("mr.arthur".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryRed
                    )
                    .multilineTextAlignment(.center)
                Group{
                    Text("helps your child maintain a healthy level of screen time. No more zombie children and especially".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text(" no \nmore arguments!".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                }
                .multilineTextAlignment(.center)
            }
        }
    }
}

//struct ManifestoMrarthurNurseView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoMrarthurNurseView()
//    }
//}
