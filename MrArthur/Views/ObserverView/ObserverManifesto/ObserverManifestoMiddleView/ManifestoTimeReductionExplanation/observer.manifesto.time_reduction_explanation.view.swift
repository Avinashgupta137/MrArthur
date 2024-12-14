//
//  observer.manifesto.time_reduction_explanation.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoTimeReductionExplanation: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Image(UtilityMethod.isFrench ? "stepOnboardingObserverManifestoTimeReductionExplanationFrench" : "stepOnboardingObserverManifestoTimeReductionExplanation")
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
                    Text("Your child will give you the ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("screen time ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("they’re willing to cut down to in %…".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
            }
            
            Spacer(minLength: 16.h)
        }
    }
}

struct ManifestoTimeReductionExplanation_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoTimeReductionExplanation()
            .multiPreview
    }
}
