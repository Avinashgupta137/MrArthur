//
//  SignInValidationCodeView.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import SwiftUI
import UserNotifications

struct SignInValidationCodeView: View {
    @State private var codeUnable = false
    @State private var isValid = true
    @State var isMultiLine = true
    @ObservedObject var input = NumbersOnly()
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    @StateObject private var observer = Observed()
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
    var body: some View {
        LoadingView {
            VStack(spacing: 0){
                HStack(spacing: 0){
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Sign in".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                            .padding(.bottom, 16.h)
                        Group {
                            if(!isValid){
                                VStack (alignment: .leading){
                                    Text("Incorrect PIN.".localized)
                                        .fontModifier(
                                            font: .montserratRegular,
                                            size: iPhoneFont18,
                                            color: .forthRed
                                        )
                                    Text("Please enter your PIN again.".localized)
                                        .fontModifier(
                                            font: .montserratRegular,
                                            size: iPhoneFont18,
                                            color: .forthRed
                                        )
                                }
                            }
                            else if(!codeUnable){
                                Text("Please enter the PIN sent to your address".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont18,
                                        color: .primaryBlue
                                    )
                                    .padding(.bottom, 5.h)
                                Text(email)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont18,
                                        color: .primaryBlue
                                    )
                            }
                        }
                    }
                    Spacer(minLength: 16.w)
                }
                .frame(height: 140.h, alignment: .top)
                VStack(alignment: .leading, spacing: 8.resizable) {
                    Text("PIN")
                        .fontModifier(
                            font: .montserratRegular,
                            size: 22,
                            color: .primaryBlue
                        )
                    
                    TextField("", text: $input.value)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                        .font(
                            AppFont.MontserratRegularFont(
                                fontSize: 22.resizable)
                        )
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad )
                        .padding(.horizontal, 16)
                        .frame(
                            height: 67.h
                        )
                        .background(
                            Color.white
                                .cornerRadius(34.r)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 34.r)
                                .stroke(
                                    Color.red,
                                    lineWidth: (isValid) ? 0 : 3
                                )
                        )
                }
                
                
                HStack(spacing: 0) {
                    Button {
                        loaderObserver.showLoader = true
                        AmplitudeService.sendEvent(key: .OBS_LOG_2_1_DID_NOT_RECEIVE_A_PIN)
                        observer.didNotReceivePin { status, msg in
                            loaderObserver.showLoader = false
                            if(status == true){
                                codeUnable = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    codeUnable = false
                                }
                            }
                        }
                    } label: {
                        Text("I DIDN’T RECEIVE A PIN".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                            .underline()
                    }
                    Spacer(minLength: 16.w)
                }
                .padding(.top, 20.h)
                Group {
                    if codeUnable {
                        VStack(spacing: 30.h){
                            Spacer(minLength: 16.h)
                            Image("iconValidateBig")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 155.51.w, height: 119.52.h)
                            Text("New Pin sent".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15,
                                    color: .primaryBlue
                                )
                            Spacer(minLength: 16.h)
                        }
                    } else {
                        Spacer(minLength: 16.h)
                    }
                }
                
                BlueRoundedButton(
                    "SUBMIT",
                    width: 221,
                    height: 60
                ) {
                    AmplitudeService.sendEvent(key: .OBS_LOG_2_1_SUBMIT)
                    onConfirm()
                }
                .padding(.bottom, 16.h)
                .opacity(codeUnable ? 0 : 1)
                .disabled(codeUnable)
            }
            .padding(.horizontal, 24.w)
            .padding(.top, 31.h)
        }
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "",
            color: .white,
            amplitudeEvent: .OBS_LOG_2_1_BACK
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .center
            )
            .edgesIgnoringSafeArea(.all)
        )
        .onOpenURL { url in
            if let code = UserLoginService.getValidationCodeFromOpenUrl(url: url) {
                input.value = code
                self.onConfirm()
            }
        }
    }
    
    func signInValidationCode()->Bool{
        let pin = input.value.trimmingLeadingAndTrailingSpaces()
        print("UserPin: \(pin)")
        if(pin.count == 0){
            print("Please enter validate code".localized)
            isValid = false
            return false
        }else{
            isValid = true
            return true
        }
    }
    
    private func onConfirm() {
        if (self.signInValidationCode()) {
            loaderObserver.showLoader = true
            let emailId = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
            let pin = input.value.trimmingLeadingAndTrailingSpaces()
            let validationCodeParameters = [
                "code": pin,
                "email": emailId
            ] as [String: Any]
            
            LoginHelper.validateAPICall(
                withToken: ConstantOfApp.kNoneTokenSend,
                param: validationCodeParameters,
                success: { value in
                    UtilityMethod().saveInDefault(
                        value: ConstantOfApp.kExistingUser,
                        key: ConstantOfApp.kIsUserNewOrExist
                    )
                    AppDetails.setLoginStatus(status: true)
                    loaderObserver.showLoader = false
                    print("Redirect to \(value)")
                    var manifestoIndex: Int = 0
                    var howitworkIndex: Int = 0
                    var rootScreen: ERootView = .welcome
                    if let data = value as? (manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
                        manifestoIndex = data.manifestoIndex
                        howitworkIndex = data.howitworkIndex
                        rootScreen = data.rootScreen
                    }else if let data = value as? ERootView{
                        print("else Redirect to \(value)")
                        rootScreen = data
                    }
                    let currentNotification = UNUserNotificationCenter.current()
                    currentNotification.getNotificationSettings(completionHandler: { (settings) in
                        DispatchQueue.main.async {
                            if settings.authorizationStatus == .notDetermined {
                                notificationNotEnabeled(
                                    manifestoIndex: manifestoIndex,
                                    howitworkIndex: howitworkIndex,
                                    rootScreen: rootScreen
                                )
                            } else if settings.authorizationStatus == .denied || settings.authorizationStatus == .authorized  {
                                notificationEnabeled(
                                    manifestoIndex: manifestoIndex,
                                    howitworkIndex: howitworkIndex,
                                    rootScreen: rootScreen
                                )
                            }
                        }
                    })
                },
                failure: { error in
                    loaderObserver.showLoader = false
                    isValid = false
                }
            )
        }
    }
    
    private func notificationEnabeled(manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
        rootViewObserver.currentPage = rootScreen
        observerManifestoObservedObject.currentIndex = manifestoIndex
        observerManifestoObservedObject.currentHowItWorksIndex = howitworkIndex
    }
    
    private func notificationNotEnabeled(manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
        let signInResponeRoute = SignInResponeRoute(
            manifestoIndex: manifestoIndex,
            howitworkIndex: howitworkIndex,
            rootScreen: rootScreen.rawValue
        )
        UserDefaultsHelper.signInResponeRoute = signInResponeRoute
        rootViewObserver.currentPage = .addUpNotificationView
    }
}

struct SignInValidationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SignInValidationCodeView()
    }
}
