//
//  observer.manifesto.there_is_hope.view.swift
//  MrArthur
//
//  Created by IPS-157 on 14/07/22.
//

import SwiftUI

struct ManifestoThereIsHope: View {
    @StateObject private var observed = Observed()
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0) {
                Text("70% of children admit to spending too much time on their screens.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                    .padding(.bottom, 10.h)
                
                Text("There’s still hope!".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25, color: .primaryRed
                    )
                
            }
            .padding(.top, statusBarHeight)
            .padding(.bottom, 100.h)
            .padding(.top, 50.h)
            Image("stepOnboardingObserverManifestoThereIsHope")
                .resizable()
                .scaledToFit()
            
            Spacer(minLength: 188.h)
        }
        .padding(.horizontal, 24.w)
        .frame(width: UIScreen.screenWidth)
        .background(Color.secondaryRed)
    }
}

struct ManifestoThereIsHope_Previews: PreviewProvider {
    static var previews: some View {
        ManifestoThereIsHope()
            .multiPreview
    }
}
