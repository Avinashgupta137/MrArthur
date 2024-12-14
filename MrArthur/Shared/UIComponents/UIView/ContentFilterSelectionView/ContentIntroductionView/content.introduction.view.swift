//
//  content.introduction.view.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//

import SwiftUI

struct ContentIntroductionView: View {
    
    var contentTitle : String
    var contentImage : String
    var contentColor : Color
    
    var body: some View {
        HStack(spacing: 0) {
            Image(contentImage)
                .resizable()
                .scaledToFit()
                .frame(width: 24.r, height: 24.r)
                .padding(.trailing, 16.w)
            
            Text(contentTitle)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont15,
                    color: contentColor
                )
            
            Spacer()
        }
    }
}

/*
struct ContentIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ContentIntroductionView(
                contentTitle: "- downtime period (preset 21h-7h can be modified)".localized,
                contentImage: "SettingsFilteringDetailsRed02"
            )
            Spacer()
        }
        .padding(30)
        .fullScreenFrame
        .background(Color.white)
    }
}
*/
