//
//  CustomAlertPopup.swift
//  MrArthur
//
//  Created by IPS-157 on 05/08/22.
//

import SwiftUI

struct CustomAlertPopup: View {
    var alertHeading: String
    var leftButtonTitle: String
    var rightButtonTitle: String
    let action: (Bool) -> ()
    var body: some View {
        
        VStack(spacing: 24.h) {
            Text(alertHeading)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont15,
                    color: .primaryBlue
                )
                .multilineTextAlignment(.center)
            
            HStack(spacing: 12.w){
                BlueRoundedButton(
                    leftButtonTitle,
                    width: 141,
                    height: 50
                ) {
                    action(false)
                }
                
                BlueRoundedButton(
                    rightButtonTitle,
                    width: 141,
                    height: 50,
                    color: .primaryRed
                ) {
                    action(true)
                }
            }
        }
        .padding(24.r)
        .frame(maxWidth: 334.w, minHeight: 190.h)
        .background(Color.secondaryRed)
        .cornerRadius(24.r)
    }
}


struct AlertPopUpView: View {
    var alertHeading: String
    var buttonTitle: String
    let action: (Bool) -> ()
    var body: some View {
        
        VStack(spacing: 24.h) {
            Text(alertHeading)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont15,
                    color: .primaryBlue
                    
                )
                .multilineTextAlignment(.center)
            Button{
                action(false)
            } label: {
                Text(buttonTitle.localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15
                    )
                    .padding(.horizontal,.dynamicValue(
                        foriPhone: 32,
                        foriPad: 50
                    ))
                    .padding(.vertical,.dynamicValue(
                        foriPhone: 12,
                        foriPad: 20
                    ))
                    .background(
                        RoundedRectangle(cornerRadius: 25.r)
                            .fill(Color.primaryBlue)
                    )
            }
            .contentShape(Rectangle())
        }
        .padding(24.r)
        .frame(width: 334.w)
        .background(Color.secondaryRed)
        .cornerRadius(24.r)
    }
}
/*
struct AlertPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            AlertPopUpView(
                alertHeading: "Do you really want to log out?".localized,
                buttonTitle: "CANCELCANCELCANCEL".localized,
                action: { _ in
                    
                }
            )
            Spacer()
        }
    }
}
 */

struct FamilyAuthFailurePopUpView: View {
    var alertMessage: String
    var actionButtonTitle: String
    let action: () -> ()
    let actionButtonShow : Bool
    let contactSupport: () -> ()
    var body: some View {
        VStack(
            alignment: .center,
            spacing: .dynamicValue(
                foriPhone: 16,
                foriPad: 32
            )
        ) {
            VStack(alignment: .center, spacing: 20){
                Image("SettingsAlarmError")
                Text(alertMessage)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .multilineTextAlignment(.center)
            }
            VStack(spacing: 10){
                Button {
                    action()
                } label: {
                    Text(actionButtonTitle)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont15
                        )
                        .padding(.horizontal,.dynamicValue(
                            foriPhone: 32,
                            foriPad: 50
                        ))
                        .padding(.vertical,.dynamicValue(
                            foriPhone: 12,
                            foriPad: 20
                        ))
                        .background(Color.secondaryBlue)
                        .clipShape(Capsule())
                }
                .opacity(actionButtonShow ? 1 : 0)
                .disabled(!actionButtonShow)
                Button {
                    contactSupport()
                } label: {
                    Text("Contact support")
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont12,
                            color: .blue
                        )
                        .underline()
                        .padding()
                        .clipShape(Capsule())
                }
            }
            .padding(.top,20)
        }
        .padding(20.resizable)
        .background(Color.secondaryRed)
        .cornerRadius(20.resizable)
    }
}
