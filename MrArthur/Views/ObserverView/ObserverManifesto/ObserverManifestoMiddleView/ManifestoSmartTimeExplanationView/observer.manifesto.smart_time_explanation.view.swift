//
//  observer.manifesto.smart_time_explanation.view.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import SwiftUI

struct ManifestoSmartTimeExplanationView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Image(UtilityMethod.isFrench ? "stepOnboardingObserverManifestoSmartTimeExplanationFrench" : "stepOnboardingObserverManifestoSmartTimeExplanation")
                .resizable()
                .scaledToFit()
                .padding(.top, statusBarHeight)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)

            
            ManifestoTextContainerView {
                Group{
                       Text("…and a % of".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                       Text("OBS_MANIFEST_EDUCATIONTIME".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                       Text("they're willing to introduce in the remaining time.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                   }
                   .multilineTextAlignment(.center)
                   .padding(.bottom, 10.h)
                
            }
            Spacer(minLength: 16.h)
        }
    }
}

struct ManifestoSmartTimeExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoSmartTimeExplanationView()
            .multiPreview
    }
}
