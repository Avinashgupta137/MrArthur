//
//  attendee.setting.login.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 03/11/22.
//

import SwiftUI

struct AttendeeSettingLoginView: View {
    @State private var showValidation = false
    @State private var observerEmail : String = ""
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    //For valid email
    @State private var isValidEmail = true
    @State private var isNullEmail = false
    @State var isMultiLine = false
    @Binding var shouldPopToRootView : Bool
    // For Loader
    @EnvironmentObject private var loaderObserver: LoaderObserver
    var body: some View {
        LoadingView {
            VStack{
                VStack(alignment: .leading, spacing: 0) {
                    if(isValidEmail){
                        Text("Please enter your login e-mail address.".localized)
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
                        title: "E-MAIL".localized,
                        fontSize: 18,
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
                    AmplitudeService.sendEvent(
                        key: .ATT_PLUS_LOG_OUT_MAIL_1_CONFIRM
                    )
                    onConfirm()
                }
                .padding(.bottom, 20.resizable)
                NavigationLink(
                    "",
                    destination:  AttendeeSeetingLoginValidationView(shouldPopToRootView: $shouldPopToRootView),
                    isActive: $showValidation
                )
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
        .customNavigationViewWithBackCancelWidgit(
            title: "More".localized,
            color: .whiteColor,
            lastButtontitle: "CANCEL",
            amplitudeEvent: .ATT_PLUS_LOG_OUT_MAIL_1_BACK,
            action: {
                AmplitudeService.sendEvent(
                    key: .ATT_PLUS_LOG_OUT_MAIL_1_CANCEL
                )
                self.shouldPopToRootView = false
            }
        )
        .background(
            LinearGradient(
                colors: [Color.secondaryRed,Color.lightPink],
                startPoint: .top,
                endPoint: .center
            )
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
            let loginrequest = LoginRequestModel.init(email: email, language: userlang)
            if let  param = try? loginrequest.asDictionary() {
                LoginHelper.loginAPICall(withToken: ConstantOfApp.kNoneTokenSend, param: param) { error, status  in
                    DispatchQueue.main.async {
                        loaderObserver.showLoader = false
                    }
                    if let error = error, !error.isEmpty {
                        print("error is = \(error ?? "hbb")")
                    } else {
                        UtilityMethod().saveInDefault(value: email, key: ConstantOfApp.kEmailId)
                        showValidation = true
                    }
                    
                }
            }
        }
    }
}

