//
//  observer.addup.privacy.view.swift
//  MrArthur
//
//  Created by IPS-157 on 06/09/22.
//

import SwiftUI
import AppTrackingTransparency

struct ObserverAddupPrivacyView: View {
    let fromSingIn: Bool
    @State var checkTermsCondition : Bool = false
    @State var showTermsCondition = false
    @State private var showObserverManifesto = false
    @State var strToastMessage = ""
    @State var showToast = false
    @State var showSignin = false
    @EnvironmentObject private var observerManifestoObservedObject : ObserverManifesto
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var observed = Observed()
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    
    
    var spacer: some View {
        Spacer(minLength: 16.h)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack(alignment: .leading) {
                HStack{
                    Spacer(minLength: 85.h)
                    Text("Privacy".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont20,
                            color: Color.primaryBlue
                        )
                        .lineLimit(1)
                    Spacer()
                }
                .zIndex(0)
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack(spacing: 8.w){
                        Image(systemName: "chevron.backward")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20, alignment: .leading)
                            .foregroundColor(.forthRed)
                        Text("Back".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryRed
                            )
                    }
                }
                .padding(.leading, 16.w)
                .opacity(fromSingIn ? 1 : 0)
                .disabled(!fromSingIn)
            }
            .padding(.top, statusBarHeight)
            .padding(.vertical, 10.w)
            .background(Color.whiteColor)
            
            VStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 12.h){
                    Text("Your family privacy matters".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    Text("• Your personal data is only used to give you personalized coaching experience.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    Text("• We do not share your personal data to third parties.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    Text("• Your data stays between you and us.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    
                }
                .padding(.top, 32.h)
                
                spacer
                
                Image("Privacy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 254.w, height: 207.h)
                    .padding(.bottom, 32.h)
                
                HStack(spacing: 20.h) {
                    Toggle("", isOn: $checkTermsCondition)
                        .scaleEffect(1.r)
                        .toggleStyle(OverlayToggleStyle(color: .primaryBlue))
                    
                    Button {
                        showTermsCondition = true
                        AmplitudeService.sendEvent(key: .OBS_ADD_UP_PRIVACY_1_AGREE_PRIVACY)
                    } label: {
                        HStack(spacing: 0){
                            Group{
                                Text("I agree to ".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                +
                                Text("the terms of use ".localized)
                                    .fontModifier(
                                        font: .montserratBlack,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                    .underline()
                                +
                                Text(" and ".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    ) +
                                Text("privacy policy.".localized)
                                    .fontModifier(
                                        font: .montserratBlack,
                                        size: iPhoneFont15,
                                        color: .primaryBlue
                                    )
                                    .underline()
                            }
                            .multilineTextAlignment(.leading)
                        }
                    }
                }
                spacer
                
                BlueRoundedButton(
                    "APPLY".localized,
                    width: 221,
                    height: 60
                ) {
                    AppsFlyerService.start()
                    if(checkTermsCondition == true){
                        AmplitudeService.sendEvent(key: .OBS_ADD_UP_PRIVACY_1_APPLY)
                        ATTrackingManager.requestTrackingAuthorization{ status in
                            switch status{
                            case .notDetermined:
                                AppsFlyerService.logEvent(key: EAppsFlyerEventKey.TRACKING_NOT_DETERMINED)
                                AmplitudeService.sendEvent(key: .OBS_ADD_UP_PRIVACY_POP_UP_3_ASK_APP_NOT_TO_TRACK)
                                self.screenRedirection()
                                break
                            case .restricted:
                                AppsFlyerService.logEvent(key: EAppsFlyerEventKey.TRACKING_RESTRICTED)
                                AmplitudeService.sendEvent(key: .OBS_ADD_UP_PRIVACY_POP_UP_3_ASK_APP_NOT_TO_TRACK)
                                self.screenRedirection()
                                break
                            case .denied:
                                AppsFlyerService.logEvent(key: EAppsFlyerEventKey.TRACKING_DENIED)
                                AmplitudeService.sendEvent(key: .OBS_ADD_UP_PRIVACY_POP_UP_3_ASK_APP_NOT_TO_TRACK)
                                self.screenRedirection()
                                break
                            case .authorized:
                                dump("TRACKING AUTHORIZED")
                                AppsFlyerService.logEvent(key: EAppsFlyerEventKey.TRACKING_ALLOWED)
                                AmplitudeService.sendEvent(key: .OBS_ADD_UP_PRIVACY_POP_UP_3_ALLOW)
                                self.screenRedirection()
                                break
                            default:
                                break
                            }
                            print("Status of tracking: - \(status)")
                        }
                    }else{
                        strToastMessage = "Please accept terms & condition".localized
                        showToast = true
                    }
                }
                .padding(.bottom, 32.h)
                
            }
            .padding(.horizontal, 16.w)
            
//            NavigationLink(
//                "",
//                destination: TermsConditionView(checkTermsCondition: $checkTermsCondition),
//                isActive: $showTermsCondition
//            )
//            .labelsHidden()
            
//            NavigationLink(
//                "",
//                destination: ObserverManifestoMainView(),
//                isActive: $showObserverManifesto
//            )
//            .labelsHidden()
            
//            NavigationLink(
//                "",
//                destination: SignInView(),
//                isActive: $showSignin
//            )
//            .labelsHidden()
        }
        .fullScreenFrame
        .hideNavigation
        .navigationDestination(isPresented: $showSignin) {
            SignInView()
        }
        .navigationDestination(isPresented: $showObserverManifesto) {
            ObserverManifestoMainView()
        }
        .navigationDestination(isPresented: $showTermsCondition) {
            TermsConditionView(checkTermsCondition: $checkTermsCondition)
        }
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
    }
    func screenRedirection(){
        if(fromSingIn == false){
            observerAPICall()
        }else{
            showSignin = true
        }
    }
    
    func observerAPICall(){
        observed.fetchLaunchResponse { error, status in
            if status {
                observerManifestoObservedObject.currentIndex = (UserDefaultsHelper.latestStep ?? 0) + 1
                UserDefaultsHelper.userHasAcceptedPrivacyPolicy = true
                self.showObserverManifesto = true
            } else {
                print("error message is \(error ?? "") for first launch screen")
            }
        }
    }
}

struct ObserverAddupPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        ObserverAddupPrivacyView(fromSingIn: true)
    }
}
