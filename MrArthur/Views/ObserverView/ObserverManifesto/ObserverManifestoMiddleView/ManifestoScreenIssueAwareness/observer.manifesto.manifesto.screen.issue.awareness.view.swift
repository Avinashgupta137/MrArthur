//
//  observer.manifesto.manifesto_screen_issue_awareness.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoScreenIssueAwarenessView: View {
    let image = "stepOnboardingObserverManifestoScreenIssueAwareness"
    let height = ScreenUtils.heightByScreenPercent(50) - statusBarHeight
    var body: some View {
        VStack(spacing: 0){
            
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 35.h)
                .padding(.top, 66.h)
                .frame(
                    width: UIScreen.screenWidth,
                    height: height
                )
                .background(Color.secondaryRed)
                .padding(.top, statusBarHeight)
            
            ManifestoTextContainerView {
                Group{
                    Text("By not turning a blind eye to ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("excessive screen time!".localized)
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

struct ManifestoScreenIssueAwarenessView_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoScreenIssueAwarenessView()
            .multiPreview
    }
}
