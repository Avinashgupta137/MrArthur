//
//  observer.manifesto.manifesto_healthy_screen_use.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoHealthyScreenUseView: View {
    let image = "stepOnboardingObserverManifestoHealthyScreenUse"
    let height = ScreenUtils.heightByScreenPercent(50) - statusBarHeight
    var body: some View {
        VStack(spacing: 0){
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.top, 73.h)
                .padding(.bottom, 44.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: height
                )
                .background(Color.secondaryRed)
                .padding(.top, statusBarHeight)
            
            ManifestoTextContainerView {
                Group{
                    Text("Healthy screen time ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("means less screen time".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text(" and ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("better content".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    
                    +
                    Text("for your child.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
            }
        }
        .fullScreenFrame
    }
}

struct ManifestoHealthyScreenUseView_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoHealthyScreenUseView()
    }
}
