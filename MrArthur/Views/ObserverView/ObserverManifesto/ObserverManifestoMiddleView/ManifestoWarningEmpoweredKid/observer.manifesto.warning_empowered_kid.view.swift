//
//  observer.manifesto.warning_empowered_kid.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoWarningEmpoweredKid: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(UtilityMethod.isFrench ? "stepOnboardingObserverManifestoMakeTheFirstStepAgainstTyrannyFrench" : "stepOnboardingObserverManifestoMakeTheFirstStepAgainstTyranny")
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50) - statusBarHeight
                )
                .clipped()
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

                Group {
                    Text("will empower your child".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text(" to take the first step".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 16.h)

            }
        }
    }
}

struct ManifestoWarningEmpoweredKid_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoWarningEmpoweredKid()
            .multiPreview
    }
}
