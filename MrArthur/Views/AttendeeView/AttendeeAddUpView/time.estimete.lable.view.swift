//
//  time.estimete.lable.view.swift
//  MrArthur
//
//  Created by BAPS on 09/11/22.
//

import SwiftUI

struct TimeEstimateLabelView: View {
    let text: String
    var body: some View {
        HStack(spacing: 0){
            Text(text.localized)
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
            Spacer(minLength: 16.w)
        }
            .padding(.horizontal, 24.w)
    }
}

