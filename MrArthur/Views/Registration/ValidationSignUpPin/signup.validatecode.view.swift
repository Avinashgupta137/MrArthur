//
//  ValidateCode.swift
//  MrArthur
//
//  Created by IPS-169 on 19/07/22.
//

import SwiftUI

struct SignUpValidationCodeView: View {
    //observed object
    @StateObject private var observed = Observed()
    @ObservedObject var input = NumbersOnly()
    @State private var codeUnable = false
    @State private var isValid = true
    @State var isMultiLine = true
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    let email = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
    
    var body: some View {
        LoadingView {
            VStack(spacing: 0){
                HStack(spacing: 0){
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Sign up".localized)
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
                        AmplitudeService.sendEvent(
                            key: .OBS_MAIL_INPUT_1_DID_NOT_RECEIVE_A_PIN
                        )
                        loaderObserver.showLoader = true
                        observed.didNotReceivePin { status, msg in
                            DispatchQueue.main.async {
                                self.loaderObserver.showLoader = false
                                if(status == true){
                                    codeUnable = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        codeUnable = false
                                    }
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
                    "SIGN UP",
                    width: 221,
                    height: 60
                ) {
                    AmplitudeService.sendEvent(
                        key: .OBS_MAIL_INPUT_1_SIGN_UP
                    )
                    onSignUp()
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
            amplitudeEvent: .OBS_MAIL_INPUT_1_BACK
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
                self.onSignUp()
            }
        }
    }
    
    func validateSignupCode()->Bool{
        let pin = input.value.trimmingLeadingAndTrailingSpaces()
        if(pin.count == 0){
            print("Please enter validate code".localized)
            isValid = false
            return false
        }else{
            isValid = true
            return true
        }
    }
    
    private func onSignUp() {
        if(validateSignupCode()){
            loaderObserver.showLoader = true
            let emailId = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId) as? String ?? ""
            let pin = input.value.trimmingLeadingAndTrailingSpaces()
            let validatecoderequestmodel = ValidationCodeApiRequestModel(
                email: emailId,
                code: pin
            )
            if let paramvatcode = try? validatecoderequestmodel.asDictionary(){
                LoginHelper.validateAPICall(
                    withToken: ConstantOfApp.kObserverTokenSend,
                    param: paramvatcode,
                    success: { value in
                        loaderObserver.showLoader = false
                        AppDetails.setLoginStatus(status: true)
                        UtilityMethod().saveInDefault(
                            value: ConstantOfApp.kNewUser,
                            key: ConstantOfApp.kIsUserNewOrExist
                        )
                        AppsFlyerService.logEvent(key: EAppsFlyerEventKey.SIGN_UP)
                        rootViewObserver.currentPage = .addUpNotificationView
                    },
                    failure: { error in
                        loaderObserver.showLoader = false
                        isValid = false
                    }
                )
            } else{
                print("Error Message")
            }
        }
    }
}

//struct SignUpValidationCodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpValidationCodeView()
//            .multiPreview
//    }
//}
