//
//  no.content.filterselection.view.swift
//  MrArthur
//
//  Created by BAPS on 22/11/22.
//

import SwiftUI

struct NoContentFilterselectionView: View {
    @State private var isLowLevel = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isSelected : Bool
    let onTap:  ()->()
    var body: some View {
        VStack(spacing: 0){
            
            HStack(spacing: 0){
                Image("noShieldIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 46.r,
                        height: 54.r
                    )
                Text("No content filtering".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont21,
                        color: .primaryBlue
                    )
                    .padding(.leading, 14)
                Spacer(minLength: 14.w)
                Button {
                    withAnimation {
                        isLowLevel.toggle()
                    }
                } label: {
                    Image(isLowLevel ? "SettingsBulletCarrot2" :"SettingsBulletCarrot1")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 40.r,
                            height: 40.r
                        )
                }
            }
            
            if isLowLevel {
                Rectangle()
                    .foregroundColor(.primaryRed.opacity(0.3))
                    .frame(height: 2)
                    .cornerRadius(2)
                    .padding(.vertical, 22.h)
            }
            
            VStack(spacing : 0) {
                Text("• All content allowed (Apps & Media).".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .padding(.horizontal,24.w)
                BlueRoundedButton(
                    "CHOOSE",
                    width: 225.46
                ) {
                    withAnimation {
                        isLowLevel.toggle()
                    }
                    onTap()
                }
                .padding(.vertical, 44.h)
            }
            .frame(height: isLowLevel ? nil : 0)
            .clipped()
        }
        .padding(.vertical, 16.h)
        .padding(.horizontal, 18.w)
        .background(Color.whiteColor.cornerRadius(28.r))
        .overlay(
            RoundedRectangle(
                cornerRadius: 28.r
            )
            .inset(by: 1)
            .stroke(Color.validateGreen, lineWidth: 3.h)
            .opacity(isSelected ? 1 : 0)
        )
    }
}

//struct no_content_filterselection_view_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            NoContentFilterselectionView(
//                isSelected: .constant(false),
//                onTap: {}
//            )
//            Spacer()
//        }
//        .padding(24.r)
//        .background(Color.forthRed)
//    }
//}
