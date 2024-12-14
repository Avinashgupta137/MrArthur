//
//  observer.manifesto.ai_prognosis_explanation.view.swift
//  MrArthur
//
//  Created by IPS-157 on 15/07/22.
//

import SwiftUI

struct ManifestoAiPrognosisExplanation: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image(UtilityMethod.isFrench ? "stepOnboardingObserverManifestoMrArthurAIPrognosisExplanationFrench" : "stepOnboardingObserverManifestoMrArthurAIPrognosisExplanation")
                .resizable()
                .scaledToFit()
                .padding(.top, statusBarHeight + 50.h)
                .padding(.bottom, 30.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group{
                    Text("mr.arthur\n".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("and its AI will help respond to this proposal.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
            }
        }
    }
}

struct ManifestoAiPrognosisExplanation_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoAiPrognosisExplanation()
            .multiPreview
    }
}
