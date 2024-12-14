//
//  FirstLaunchScreenView.swift
//  MrArthur
//
//  Created by IPS-15
import SwiftUI

struct FirstLaunchScreenView: View {
    
    @StateObject private var observed = Observed()
    @State private var showSignin = false
    @State private var showaddPrivacy = false
    
    var body: some View {
        VStack(spacing:0) {
            VStack(alignment: .leading, spacing: 20){
                Text("Hello !".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25
                    )
                Group {
                    Text("mr.arthur ".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25
                        )
                    +
                    Text("helps your children cut their screen time".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont25
                        )
                }
                Text("Teach your children to be more self-aware and responsible for their actions.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont25
                    )
            }
            .padding(
                EdgeInsets(
                    top: 50.h,
                    leading: 20.w,
                    bottom: 0,
                    trailing: 20.w
                )
            )
            
            Spacer(minLength: 16.h)
            
            Image("WelcomeConnect")
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.screenWidth,
                    height: ScreenUtils.heightByScreenPercent(25).h
                )
            Spacer(minLength: 16.h)
            
            BlueRoundedButton(
                "START".localized,
                width: 184,
                height: 60
            ) {
                AmplitudeService.sendEvent(key: .OBS_1ST_SCREEN_1_START)
                showaddPrivacy = true
            }
            .padding(.bottom, 42.h)
            
            Text("Already have an account?".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont15
                )

            Button {
                showSignin = true
                AmplitudeService.sendEvent(key: .OBS_1ST_SCREEN_1_SIGN_IN)
            } label: {
                Text("SIGN IN".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15,
                        color: .whiteColor
                    )
                    .underline()
                    .frame(
                        width: ScreenUtils.widthByScreenPercent(45).w,
                        height: 40.h
                    )
            }
            .contentShape(Rectangle())
            .padding(.bottom, 24.h)
            
            NavigationLink(
                "",
                destination: ObserverAddupPrivacyView(fromSingIn: true),
                isActive: $showSignin
            )
            
            NavigationLink(
                "",
                destination: ObserverAddupPrivacyView(fromSingIn: false) ,
                isActive:$showaddPrivacy
            )
        }
        .hideNavigation
        .statusBarStyle(color: .white)
        .fullScreenFrame
        .background(
            LinearGradient(
                colors: [
                    Color.primaryRed,
                    Color.thirdRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
}
struct FirstLaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchScreenView()
    }
}
