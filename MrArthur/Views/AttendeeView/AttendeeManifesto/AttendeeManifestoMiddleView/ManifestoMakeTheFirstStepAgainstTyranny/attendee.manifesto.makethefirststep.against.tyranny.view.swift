//
//  ManifestoMakeTheFirstStepAgainstTyranny.swift
//  MrArthur
//
//  Created by IPS-157 on 01/08/22.
//

import SwiftUI

struct ManifestoMakeTheFirstStepAgainstTyranny: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image(UtilityMethod.isFrench ? "stepOnboardingAttendeeManifestoMakeTheFirstStepAgainstTyrannyFrench" : "stepOnboardingAttendeeManifestoMakeTheFirstStepAgainstTyranny")
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
                Group{
                    Text("To avoid living hell and complete parental control, ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("you must make the first move ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size:  iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text("and challenge yourself!".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8.w)
                
            }
        }
    }
}

struct ManifestoMakeTheFirstStepAgainstTyranny_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoMakeTheFirstStepAgainstTyranny()
            .multiPreview
    }
}
