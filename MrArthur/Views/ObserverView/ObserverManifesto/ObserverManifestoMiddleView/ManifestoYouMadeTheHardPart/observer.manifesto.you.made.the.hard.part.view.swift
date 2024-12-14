//
//  observer.manifesto.you_made_the_hard_part.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoYouMadeTheHardPartView: View {
    var body: some View {
        VStack(spacing: 0){
            
            Spacer(minLength: 16.h)
            
            Text("Well done,".localized)
                .fontModifier(
                    font: .montserratBlack,
                    size:  iPhoneFont25,
                    color: .primaryRed
                )
                .padding(.bottom, 8.h)
            
            Text("you've done the hard part.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
                .padding(.bottom, 80.h)

            Image("stepOnboardingObserverManifestoYouMadeTheHardPart")
                .resizable()
                .scaledToFit()
                .frame(
                    width: UIScreen.screenWidth,
                    height: 288.h
                )

            Spacer(minLength: 16.h)
            
        }
        .statusBarStyle(color: .white)
        .fullScreenFrame
        .background(Color.secondaryRed)
    }
}

struct ManifestoYouMadeTheHardPartView_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoYouMadeTheHardPartView()
    }
}
