//
//  paringsetup.view.swift
//  MrArthur
//
//  Created by IPS-157 on 29/08/22.
//

import SwiftUI

struct ParingSetUpView: View {
    
    var paringIndexNumber: String
    var paringTitle: String
    let viewBackgroundColor: Color
    let textBackgroundColor : Color
    var imageButton : String
    var imageButtonTintColor : Color
    var fontSize : CGFloat = iPhoneFont18
    var isFullOpacity = false
    var body: some View {
        HStack(spacing: 0) {
            Text(paringIndexNumber)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont25,
                    color: .white
                )
                .frame(width: 46.r, height: 46.r)
                .background(textBackgroundColor)
                .clipShape(Circle())
                .padding(.trailing, 18.w)
            
            Text(paringTitle)
                .fontModifier(
                    font: .montserratBold,
                    size: fontSize,
                    color: .primaryBlue
                )
                
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 16.w)
            
            Image(systemName: imageButton)
                .font(.system(size: 20.r, weight: .bold))
                .foregroundColor(imageButtonTintColor)
        }
        .padding(.vertical, 22.h)
        .padding(.horizontal, 22.w)
        .background(viewBackgroundColor.cornerRadius(28.r))
        .opacity(!isFullOpacity ? 0.4 : 1.0)
    }
}

//struct ParingSetUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Spacer()
//            ParingSetUpView(
//                paringIndexNumber: "5",
//                paringTitle: "Educational app installation".localized,
//                viewBackgroundColor: .whiteColor,
//                textBackgroundColor: .primaryRed,
//                imageButton: "chevron.forward",
//                imageButtonTintColor: .primaryBlue,
//                isFullOpacity: false
//            )
//            Spacer()
//        }
//        .padding()
//        .fullScreenFrame
//        .background(Color.forthRed)
//        .multiPreview
//    }
//}

