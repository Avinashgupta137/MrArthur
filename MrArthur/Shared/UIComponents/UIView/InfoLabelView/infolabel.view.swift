//
//  InfoLabelView.swift
//  MrArthur
//
//  Created by Troo on 22/07/22.
//

import SwiftUI

struct InfoLabelView: View {
    private let iconSize: CGFloat = 35.r
    private let fontSize: CGFloat = 18
    var body: some View {
        ZStack(alignment: .top) {
            Image(systemName: "info")
                .font(.system(size: 25.r, weight: .bold))
                .foregroundColor(Color.white)
                .frame(width: iconSize, height: iconSize)
                .background(Color.primaryBlue.cornerRadius(iconSize/2))
                .zIndex(1)
            HStack{
                Group {
                    Text("Set the cursor to ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: fontSize,
                            color: .primaryBlue
                        )
                    +
                    Text("0H00\n".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: fontSize,
                            color: .primaryBlue
                        )
                    +
                    Text("if your child doesn't use or own the device.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: fontSize,
                            color: .primaryBlue
                        )
                }
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.screenWidth * 0.6)
                .padding(.vertical, 32.h)
            }
            .frame(width: 380.w)
            .overlay(
                RoundedRectangle(cornerRadius: 31.r)
                    .stroke(Color.primaryBlue, lineWidth: 1.r)
            )
            .padding(.top, iconSize/2)
            .padding(.horizontal, 24.w)
            .zIndex(0)
        }
        
    }
}

//struct InfoLabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            Spacer()
//            InfoLabelView()
//            Spacer()
//        }
//            .multiPreview
//    }
//}

