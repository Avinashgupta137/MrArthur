//
//  signup.view.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import SwiftUI

struct
SignUpView: View {
    @State var checkTermsCondition : Bool = false
    @State var showTermsCondition = false
    @State var showValidation = false
    @State var emailObserver : String = ""
    @State var isMultiLine = false
    @State private var isValidEmail = true
    @EnvironmentObject private var loaderObserver: LoaderObserver
    
    var body: some View {
        LoadingView {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Sign up".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.top, statusBarHeight + 32.h)
                        .padding(.bottom, 8.h)
                    
                    Group {
                        if(isValidEmail){
                            Text("Please provide an e-mail address.".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        } else {
                            VStack (alignment: .leading){
                                Text("Invalid e-mail format.".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont18,
                                        color: .forthRed
                                    )
                                Text("Please enter your e-mail address again.".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont18,
                                        color: .forthRed
                                    )
                            }
                        }
                    }
                    .frame(height: 70.h, alignment: .top)
                    
                    TextFieldView(
                        title: "E-MAIL".localized,
                        fontSize: 22,
                        text: $emailObserver,
                        textColor: .primaryBlue,
                        isValid: $isValidEmail,
                        isMultiLine: $isMultiLine,
                        isTextlimitFix: false
                    ) { value in
                        isValidEmail = true
                    }
                    
                }
                .padding(.bottom, 20.h)
                
                Button {
                    UIApplication.shared.endEditing()
                    showTermsCondition = true
                    AmplitudeService.sendEvent(
                        key: .OBS_MAIL_INPUT_1_AGREE_PRIVACY
                    )
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
                                    color: .primaryBlue)
                            +
                            Text("privacy policy.".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont15,
                                    color: .primaryBlue
                                )
                                .underline()
                        }
                    }
                    .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton(
                    "CONFIRM",
                    width: 200,
                    height: 60
                ) {
                    AmplitudeService.sendEvent(key: .OBS_MAIL_INPUT_1_CONFIRM)
                    onConfirm()
                }
                .padding(.bottom, 20.h)
                
                NavigationLink(
                    "",
                    destination: TermsConditionView(checkTermsCondition: $checkTermsCondition),
                    isActive: $showTermsCondition
                )
                .labelsHidden()
                NavigationLink(
                    "",
                    destination: SignUpValidationCodeView(),
                    isActive: $showValidation
                )
                .labelsHidden()
            }
            .padding(.horizontal, 24.w)
        }
        .hideNavigation
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
    
    func validateSignup()->Bool{
        let trimmedEmail = emailObserver.trimmingLeadingAndTrailingSpaces()
        if(trimmedEmail.count == 0){
            isValidEmail = false
            AmplitudeService.sendEvent(
                key: .OBS_MAIL_INPUT_1_ERROR
            )
            return false
        }else if(!trimmedEmail.textFieldValidatorEmail(trimmedEmail.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression))){
            AmplitudeService.sendEvent(
                key: .OBS_MAIL_INPUT_1_ERROR
            )
            isValidEmail = false
            return false
        }else{
            isValidEmail = true
            return true
        }
    }
    
    private func onConfirm() {
        if(validateSignup()) {
            loaderObserver.showLoader = true
            let userlang = DeviceService.getDeviceLanguage()
            let email = self.emailObserver.trimmingLeadingAndTrailingSpaces().lowercased()
            print("Final Signup Email: - \(email)")
            let loginrequest = LoginRequestModel(
                email: email,
                language: userlang
            )
            if let param = try? loginrequest.asDictionary(){
                LoginHelper.loginAPICall(withToken: ConstantOfApp.kObserverTokenSend, param: param) { error,statusOfAPI  in
                    DispatchQueue.main.async {
                        loaderObserver.showLoader = false
                        if let error = error, !error.isEmpty  {
                            loaderObserver.showLoader = false
                        } else {
                            UtilityMethod().saveInDefault(value: email, key: ConstantOfApp.kEmailId)
                            showValidation = true
                        }
                    }
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .multiPreview
    }
}
