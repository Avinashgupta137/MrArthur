//
//  MoreCardSectionView.swift
//  MrArthur
//
//  Created by IPS-157 on 04/08/22.
//

import SwiftUI

struct MoreCardSectionView: View {
    var buttonImage: String
    var isSystemImage:Bool = false
    var buttonTitle: String
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                Text(buttonTitle)
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 16.w)
                if isSystemImage{
                    Image(systemName: buttonImage)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryBlue)
                        .frame(width: 25.r, height: 25.r)
                }else{
                    Image(buttonImage)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryBlue)
                        .frame(width: 30.r, height: 30.r)
                }
            }
            .padding(.top, 20.h)
            
            Rectangle()
                .fill(Color.thirdRed)
                .frame(height: 1.h)
                .padding(.top, 20.h)
        }
    }
}
