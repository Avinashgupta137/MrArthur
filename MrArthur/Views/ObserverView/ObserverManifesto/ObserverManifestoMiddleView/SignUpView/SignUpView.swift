//
//  SignUpView.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var loginobserved = LoginHelper()
    @StateObject private var observed = Observed()
    @State var CheckTermCondition : Bool = false
    @State private var showTermsCondition = false
    @State private var showValidation = false
    @State private var username: String = ""
    @State private var text : String = ""
    @State private var strToastMessage = ""
    @State var textColor: Color = .whiteColor
    @State private var showToast = false
    // For Loader
    @EnvironmentObject private var loaderObserver: LoaderObserver
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Sign up".localized)
                    .fontModifier(font: .montserratBold, size: iPhoneFont25)
                    .padding(.bottom, 8.resizable)
                
                Text("Please provide an e-mail address.".localized)
                    .fontModifier(font: .montserratRegular, size: iPhoneFont18)
                    .padding(.bottom, 70.resizable)
                
                TextFieldView(title: "E-MAIL", fontSize: 22, text: $text, textColor: $textColor, isValid: .constant(true)) { value in
                }
                .padding(.bottom,20.resizable)
                
                HStack(spacing: 0) {
                    Toggle("", isOn: $CheckTermCondition)
                        .frame(width: 50, height: 20, alignment: .leading)
                        .scaleEffect(isiPad() ? 1.5 : 1)
                        .toggleStyle(OverlayToggleStyle())
                        .padding(.trailing, isiPad() ? 50 : 20)
                        .padding(.leading, isiPad() ? 15 : 0)
                    
                    Button {
                        withAnimation {
                            showTermsCondition = true
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 0) {
                            Group{
                                Text("I agree to ".localized)
                                    .fontModifier(font: .montserratRegular, size: iPhoneFont15)
                                +
                                Text("the terms of use".localized)
                                    .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                                    .underline()
                            }
                            Group{
                                Text("and ".localized)
                                    .fontModifier(font: .montserratRegular, size: iPhoneFont15) +
                                Text("privacy policy.".localized)
                                    .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                                    .underline()
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Button {
                if(validateSignup()){
                    loaderObserver.showLoader = true

                
                var userlang = Locale.preferredLanguages.first ?? "fr"
                    if(userlang.lowercased().contains("en")){
                        userlang = "en"
                    }else{
                        userlang = "fr"
                    }
                let  param = ["email":text,"language":userlang] as [String : Any]

                    loginobserved.loginAPICall(param: param) { error in
                        print("message is =\(error)")
                        DispatchQueue.main.async {
                            loaderObserver.showLoader = false
                        }
                        if(error?.count == 0){
                            UtilityMethod().saveindefault(value: text, key: ConstantOfApp.kemailId)
                            showValidation = true
                            
                        }else{
                            print("error is = \(error)")
                            if let errmsg = error{
                                if(errmsg.count > 0){
                                    
                                    strToastMessage = errmsg
                                    showToast = true
                                    
                                }
                            }
                        }
                    }
                }
            } label: {
                Text("CONFIRM".localized)
                    .fontModifier(font: .montserratBold, size: iPhoneFont15)
                    .frame(width: UIScreen.screenWidth * 0.4, height: 55.resizable)
                    .background(Color.primaryBlue.cornerRadius(50))
            }
            .contentShape(Rectangle())
            .padding(.bottom, 20.resizable)
            
            NavigationLink("", destination:  TermsConditionView(CheckTermCondition: $CheckTermCondition), isActive: $showTermsCondition)
                .labelsHidden()
            NavigationLink("", destination:  ValidationSignUpPinView(), isActive: $showValidation)
                .labelsHidden()
            
        }
        .toast(
            message: strToastMessage,
            isShowing: $showToast,
            duration: Toast.short
        )
        .padding(.top, statusBarHeight + 40.resizable)
        .padding(.horizontal, 24)
        .hideNavigation
        .statusBarStyle(color: .statusBarColor)
        .background(
            LinearGradient(colors: [Color.secondaryBlue, Color.thirdRed],
                           startPoint: .top,
                           endPoint: .center)
        )
    }
    func validateSignup()->Bool{
        if(self.text.count == 0){
            strToastMessage = "Please Enter email"
            showToast = true
            print("Please Enter email")
            return false
        }else if(!self.text.textFieldValidatorEmail(self.text)){
            strToastMessage = "Please add proper email id"
            showToast = true
            print("Please add proper email id")
            return false
        }else if(CheckTermCondition == false){
            strToastMessage = "Please accept terms & condition"
            showToast = true
            print("Please add proper email id")
            return false
        }else{
            return true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
