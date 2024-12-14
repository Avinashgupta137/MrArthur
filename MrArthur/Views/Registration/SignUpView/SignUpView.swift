//
//  SignUpView.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import SwiftUI

struct SignUpView: View {
    @State private var CheckTermCondition = true
    @State private var showTermsCondition = false
    @State private var username: String = ""
    @State private var text : String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20.0){
                Group{
                    Text(LocalizedStringKey("Sign up"))
                        .foregroundColor(Color.white)
                        .font(AppFont.MontserratBlackFont(fontSize: CGFloat(isiPad() ? FontSize.iPadFontSize : FontSize.iPhoneFontSize)))
                        .multilineTextAlignment(.leading)
                    Text(LocalizedStringKey("Please provide an e-mail address."))
                        .foregroundColor(Color.white)
                        .font(AppFont.MontserratRegularFont(fontSize: CGFloat(isiPad() ? FontSize.iPadFontSize : FontSize.ansiPhoneFont)))
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 24)
                VStack(alignment: .leading){
                    TextFieldView(title: "E-MAIL", fontSize: 22, text: $text, isValid: .constant(true)) { value in
                        print("on text field value change \(value)")
                    }
                    .padding(.horizontal, 24)
                }
                HStack{
                    Toggle("", isOn: $CheckTermCondition)
                        .frame(width: 50, height: 20, alignment: .leading)
                        .toggleStyle(SwitchToggleStyle(tint: .clear))
                        .padding(.horizontal, 24)
                    if CheckTermCondition {
                        
                    }
                    VStack{
                        Button(action: {
                            withAnimation {
                                showTermsCondition = true
                            }
                        }
                        ) {
                            Group{
                                Text("I agree to ")
                                    .font(AppFont.MontserratRegularFont(fontSize: CGFloat(isiPad() ? FontSize.iPadButtonFontSize : FontSize.iPhoneButtonSize))) +
                                Text("the terms of use")
                                    .font(AppFont.MontserratBlackFont(fontSize: CGFloat(isiPad() ? FontSize.iPadButtonFontSize : FontSize.iPhoneButtonSize)))
                                    .underline() +
                                Text(" and ")
                                    .font(AppFont.MontserratRegularFont(fontSize: CGFloat(isiPad() ? FontSize.iPadButtonFontSize : FontSize.iPhoneButtonSize))) +
                                Text("privacy policy.")
                                    .underline()
                                    .font(AppFont.MontserratBlackFont(fontSize: CGFloat(isiPad() ? FontSize.iPadButtonFontSize : FontSize.iPhoneButtonSize)))
                            }
                            .multilineTextAlignment(.leading)
                        }
                        .foregroundColor(Color.white)
                        
                    }
                    
                    Spacer()
                }
                Spacer()
                NavigationLink("", destination:  TermsConditionView(), isActive: $showTermsCondition)
            }
            .padding(.top, 70)
            .background(
                LinearGradient(colors: [Color.secondaryBlue, Color.thirdRed],
                               startPoint: .top,
                               endPoint: .center)
            )
            .navigationTitle("")
            .navigationBarHidden(true)
        }

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
