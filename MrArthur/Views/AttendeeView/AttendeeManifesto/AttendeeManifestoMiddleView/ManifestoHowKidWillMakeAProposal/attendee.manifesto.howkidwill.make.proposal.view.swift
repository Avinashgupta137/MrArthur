//
//  ManifestoHowKidWillMakeAProposal.swift
//  MrArthur
//
//  Created by IPS-157 on 01/08/22.
//

import SwiftUI

struct ManifestoHowKidWillMakeAProposal: View {
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image(UtilityMethod.isFrench ? "stepOnboardingAttendeeManifestoHowKidWillMakeAProposalFrench" : "stepOnboardingAttendeeManifestoHowKidWillMakeAProposal")
                .resizable()
                .padding(.top, statusBarHeight + 16.h)
                .padding(.trailing, 24.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
            
            ManifestoTextContainerView {
                Group{
                    Text("You’re going to ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size:  iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("reduce your screen time ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryRed
                        )
                    +
                    Text(" and ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size:  iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("introduce more educational time.".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size:  iPhoneFont25,
                            color: .primaryRed
                        )
                }
                .multilineTextAlignment(.center)
            }
        }
    }
}

struct ManifestoHowKidWillMakeAProposal_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoHowKidWillMakeAProposal()
            .multiPreview
    }
}
