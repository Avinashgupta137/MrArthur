//
//  attendee.seeting.login.validation.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 03/11/22.
//

import SwiftUI

struct AttendeeSeetingLoginValidationView: View {
    @ObservedObject var input = NumbersOnly()
    @State private var codeUnable = false
    @State private var showAppSetting = false
    @State private var showErrorPin = false
    @State private var isValid = true
    @State var isMultiLine = true
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
    @Binding var shouldPopToRootView : Bool
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
                        self.regeneratePin()
                        AmplitudeService.sendEvent(
                            key: .ATT_PLUS_LOG_OUT_PIN_1_DID_NOT_RECEIVE_A_PIN
                        )
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
                
                BlueRoundedButton("ACCESS SETTINGS") {
                    AmplitudeService.sendEvent(
                        key: .ATT_PLUS_LOG_OUT_PIN_1_ACCESS_SETTINGS
                    )
                    onConfirm()
                }
                .padding(.bottom, 16.h)
                .opacity(codeUnable ? 0 : 1)
                .disabled(codeUnable)
                NavigationLink(
                    "",
                    destination:  AttendeeAppsettingsView(shouldPopToRootView: $shouldPopToRootView),
                    isActive: $showAppSetting
                )
            }
            .padding(.horizontal, 24.w)
            .padding(.top, 31.h)
        }
        
        .customNavigationViewWithBackCancelWidgit(
            title: "More".localized,
            color: .whiteColor,
            lastButtontitle: "CANCEL",
            amplitudeEvent: .ATT_PLUS_LOG_OUT_MAIL_1_BACK,
            action: {
                self.shouldPopToRootView = false
                AmplitudeService.sendEvent(
                    key: .ATT_PLUS_LOG_OUT_PIN_1_CANCEL
                )
            }
        )
        
        .background(
            LinearGradient(colors: [Color.secondaryRed,Color.lightPink],
                           startPoint: .top,
                           endPoint: .center)
        )
    }
    
    func signInValidationCode() -> Bool {
        let pin = input.value.trimmingLeadingAndTrailingSpaces()
        if (pin.count == 0) {
            // TODO: handle multi language
            print("Please enter validate code".localized)
            AmplitudeService.sendEvent(
                key: .ATT_PLUS_PIN_ERROR_1
            )
            isValid = false
            return false
        } else {
            isValid = true
            return true
        }
    }
    
    private func onConfirm() {
        if (self.signInValidationCode()) {
            loaderObserver.showLoader = true
            let emailId = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
            let pin = input.value.trimmingLeadingAndTrailingSpaces()
            let validationCodeParameters = ["code": pin, "email": emailId] as [String: Any]
            LoginHelper.validateAPICall(
                withToken: ConstantOfApp.kNoneTokenSend,
                param: validationCodeParameters,
                success: { value in
                    loaderObserver.showLoader = false
                    showAppSetting = true
                },
                failure: { error in
                    loaderObserver.showLoader = false
                    showErrorPin = true
                    isValid = true
                }
            )
        }
    }
    public func regeneratePin(){
        loaderObserver.showLoader = true
        let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
        let userlang = DeviceService.getDeviceLanguage()
        
        let loginrequest = LoginRequestModel.init(email: email, language: userlang)
        if let  param = try? loginrequest.asDictionary() {
            LoginHelper.loginAPICall(
                withToken: ConstantOfApp.kNoneTokenSend,
                param: param
            ) { errormessage,status  in
                DispatchQueue.main.async {
                    loaderObserver.showLoader = false
                }
                if status {
                    codeUnable = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        codeUnable = false
                    }
                }
//                if (errormessage?.count == 0) {
//                    DispatchQueue.main.async {
//                        loaderObserver.showLoader = false
//                    }
//                    codeUnable = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        codeUnable = false
//                    }
//                } else {
//                    if errormessage != nil {
//                        DispatchQueue.main.async {
//                            loaderObserver.showLoader = false
//                        }
//                    }
//                }
            }
        }
    }
}
