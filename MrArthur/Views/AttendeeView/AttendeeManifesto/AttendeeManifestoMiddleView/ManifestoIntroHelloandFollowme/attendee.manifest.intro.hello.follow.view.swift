//
//  ManifestoIntroHelloandFollowme.swift
//  MrArthur
//
//  Created by IPS-169 on 29/07/22.
//

import SwiftUI

struct ManifestoIntroHelloandFollowme: View {
    @State var observed  =  Observed()
    
    var body: some View {
        VStack(spacing: 0){
            
            Image("stepOnboardingAttendeeManifestoIntroHelloAndFollowMe")
                .resizable()
                .scaledToFit()
                .padding(.top, statusBarHeight)
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(50)
                )
                .background(Color.secondaryRed)
                
            VStack(spacing: 0){
                
                Text("Hi,".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size:  iPhoneFont25,
                        color: .primaryRed
                    )
                    .padding(.bottom, 3.h)
                
                Text("so you‘re the one that wants to take charge of your digital life? It’s about time!".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                .multilineTextAlignment(.center)
                .padding(.bottom, 24.h)
                
                Group{
                    Text("Follow me, and I’ll introduce you to ".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    +
                    Text("mr.arthur !".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size:  iPhoneFont25,
                            color: .primaryRed
                        )
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 34.h)
                
                HStack(spacing: 12.w){
                    Image("iconTimer")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 40.r,
                            height:40.r
                        )
                    
                    Rectangle()
                        .fill(Color.primaryRed)
                        .frame(width: 2.r, height: 63.h)
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("ESTIMATED TIME".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont12, color: .primaryBlue
                            )
                        
                        Text("3 min".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont12,
                                color: .primaryBlue
                            )
                    }
                }
                Spacer(minLength: 16.h)
            }
            .padding(.horizontal, 34.w)
            
            Spacer(minLength: 16.h)
        }
        .background(Color.backgroundOffWhite)
    }
}

//struct ManifestoIntroHelloandFollowme_Previews: PreviewProvider {
//    static var previews: some View {
//        ManifestoIntroHelloandFollowme()
//            .multiPreview
//    }
//}
