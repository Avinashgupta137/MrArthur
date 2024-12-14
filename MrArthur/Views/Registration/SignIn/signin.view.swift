//
//  SignUpView.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var observed = Observed()
    @State private var showValidation = false
    @State private var observerEmail : String = ""
    
    //For Toast Message
    @State private var strToastMessage = ""
    @State private var showToast = false
    //For valid email
    @State private var isValidEmail = true
    @State private var isNullEmail = false
    @State var isMultiLine = false
    // For Loader
    @EnvironmentObject private var loaderObserver: LoaderObserver
    var body: some View {
        LoadingView {
            VStack{
                VStack(alignment: .leading, spacing: 0) {
                    Text("Sign in".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                        .padding(.bottom, 8.resizable)
                    if(isValidEmail){
                        Text("Please provide an e-mail address.".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                            .padding(.bottom, 50.resizable)
                    }else{
                        VStack (alignment: .leading){
                            Text("Invalid e-mail format.".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .forthRed)
                            
                            Text("Please enter your e-mail address again.".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .forthRed
                                )
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom, 40.resizable)
                        }
                    }
                    TextFieldView(
                        title: "E-MAIL",
                        fontSize: 22,
                        text: $observerEmail,
                        textColor: .primaryBlue,
                        isValid: $isValidEmail,
                        isMultiLine: $isMultiLine,
                        isTextlimitFix: false
                    ) { value in
                        isValidEmail = true
                    }
                    .padding(.bottom,20.resizable)
                }
                Spacer()
                BlueRoundedButton("CONFIRM"){
                    AmplitudeService.sendEvent(key: .OBS_LOG_1_BIS_CONFIRM)
                    onConfirm()
                }
                NavigationLink(
                    "",
                    destination:  SignInValidationCodeView(),
                    isActive: $showValidation
                )
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
        .customNavigationViewWithBackWithAmplitudeEvent(
            title: "",
            color: .whiteColor,
            amplitudeEvent: .OBS_LOG_1_BIS_BACK
        )
        .background(
            LinearGradient(colors: [Color.secondaryRed,Color.lightPink],
                           startPoint: .top,
                           endPoint: .center)
        )
        
    }
    func validateLogin()->Bool{
        let trimmedEmail = observerEmail.trimmingLeadingAndTrailingSpaces()
        if(trimmedEmail.count == 0){
            isValidEmail = false
            return false
        }else if(!trimmedEmail.textFieldValidatorEmail(trimmedEmail.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression))){
            isValidEmail = false
            print("Please add proper email id".localized)
            return false
        }else{
            isValidEmail = true
            return true
        }
    }
    
    private func onConfirm(){
        if(self.validateLogin()){
            loaderObserver.showLoader = true
            let userlang = DeviceService.getDeviceLanguage()
            let email = self.observerEmail.trimmingLeadingAndTrailingSpaces().lowercased()
            print("Final Sign In Email: - \(email)")
            let loginrequest = LoginRequestModel.init(
                email: email,
                language: userlang
            )
            if let  param = try? loginrequest.asDictionary(){
                LoginHelper.loginAPICall(
                    withToken: ConstantOfApp.kNoneTokenSend,
                    param: param
                ) { error, statusOfAPI  in
                    DispatchQueue.main.async {
                        loaderObserver.showLoader = false
                    }
                    if let error = error, !error.isEmpty  {
                        print("error is = \(error)")
                        showToast = true
                        strToastMessage = error
                    } else {
                        UtilityMethod().saveInDefault(
                            value: email,
                            key: ConstantOfApp.kEmailId
                        )
                        UtilityMethod().saveInDefault(value: email, key: ConstantOfApp.kObserverEmail)
                        showValidation = true
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
