//
//  onboard.conten.view.swift
//  MrArthur
//
//  Created by BAPS on 19/01/23.
//

import SwiftUI

struct OnboardContenView: View {
    let imageName: String
    let description: String
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFit()
            Spacer(minLength: 20.h)
            Text(description)
                .fontModifier(
                    font: .montserratRegular,
                    size: 22.sp,
                    color: .primaryBlue
                )
                .lineSpacing(5.h)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50.w)
            Spacer(minLength: 20.h)
        }
    }
}
