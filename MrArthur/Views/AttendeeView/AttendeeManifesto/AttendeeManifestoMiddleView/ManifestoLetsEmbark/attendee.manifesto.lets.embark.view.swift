//
//  ManifestoLetsEmbark.swift
//  MrArthur
//
//  Created by IPS-157 on 02/08/22.
//

import SwiftUI

struct ManifestoLetsEmbark: View {
    var body: some View {
        VStack(spacing: 40.h) {
            
            Image("stepOnboardingAttendeeManifestoLetsEmbark")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 371.08.w,
                    height: 474.23.h
                )
                .padding(.top, 77.h + statusBarHeight)
            
            
            Text("So,\n are you on board?".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 16.h)
        }
        .frame(width: UIScreen.screenWidth)
        .background(
            Color.secondaryRed
        )
    }
}

//struct ManifestoLetsEmbark_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoLetsEmbark()
//            .multiPreview
//    }
//}
