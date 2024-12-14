//
//  onboard.main.view.swift
//  MrArthur
//
//  Created by BAPS on 19/01/23.
//

import SwiftUI

struct OnboardMainView: View {
    
    @State var pageIndex = 0
    @State var activeStart = false
    @State var activeSignIn = false
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $pageIndex) {
                OnboardContenView(
                    imageName: "asset_onboard_step_1".localized,
                    description: "Optimize screen time, learn to play, monitor, protect from inappropriate content…".localized
                )
                .tag(0)
                OnboardContenView(
                    imageName: "asset_onboard_step_2".localized,
                    description: "Your child will have to spend time on educational apps…".localized
                )
                .tag(1)
                OnboardContenView(
                    imageName: "asset_onboard_step_3".localized,
                    description: "…to unlock entertainment time on their device.".localized
                )
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack(spacing: 10.w) {
                OnbaordIndicatorView(isFill: pageIndex == 0)
                    .animation(.default, value: pageIndex)
                
                OnbaordIndicatorView(isFill: pageIndex == 1)
                    .animation(.default, value: pageIndex)
                
                OnbaordIndicatorView(isFill: pageIndex == 2)
                    .animation(.default, value: pageIndex)
            }
            .padding(.bottom, 33.h)
            
            VStack(spacing: 0){
                Spacer(minLength: 35.h)
                BlueRoundedButton("START", width: 134) {
                    FirstLaunchAPICall.request { errorMsg, response  in
                        self.activeStart = response != nil
                    }
                }
                .padding(.bottom, 34.h)
                
                Button {
                    self.activeSignIn = true
                } label: {
                    VStack(spacing: 5.h) {
                        Text("Already have an account?".localized.uppercased())
                            .fontModifier(
                                font: .montserratRegular,
                                size: 15.sp,
                                color: .primaryBlue
                            )
                        Text("SIGN IN".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: 15.sp,
                                color: .primaryBlue
                            )
                    }
                    .padding(.vertical, 10.h)
                    .padding(.horizontal, 40.w)
                    .overlay {
                        RoundedRectangle(cornerRadius: 31.r)
                            .stroke(Color.primaryBlue, lineWidth: 2.w)
                    }
                }
                .contentShape(Rectangle())
                
                Spacer(minLength: 40.h)
            }
            .frame(width: UIScreen.screenWidth)
            .frame(height: 220.h)
            .background(
                Image("ic_onboard_background_bottom")
                    .resizable()
                    .frame(height: 220.h)
            )
            
        }
        .statusBarStyle(color: .white)
        .background(Color.secondaryRed)
        .edgesIgnoringSafeArea(.all)
        .navigationDestination(isPresented: $activeSignIn) {
            SignInView()
        }
        .navigationDestination(isPresented: $activeStart) {
            ObserverManifestoMainView()
        }
    }
}

struct OnboardMainView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardMainView()
//            .multiPreview
    }
}
