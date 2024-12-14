//
//  observer.manifesto.but_how_does_it_work.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoButHowDoesitWork: View {
    @StateObject private var observed = Observed()
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0) {
                Spacer(minLength: 16.h)
                Text("But how does it work ".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                
                Text("in practice?".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                Spacer(minLength: 16.h)
            }
            .padding(.top, 50.h)

                        
            Image("stepOnboardingObserverManifestoMrArthurHowDoesItWork")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 324.w,
                    height: 365.h
                )
            Spacer(minLength: 210.h)
        }
        .frame(width: UIScreen.screenWidth)
        .background(Color.secondaryRed)
    }
}

struct ManifestoButHowDoesitWork_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoButHowDoesitWork()
            .multiPreview
    }
}
