//
//  SetDeviceNameView.swift
//  MrArthur
//
//  Created by IPS-169 on 27/07/22.
//

import SwiftUI

struct SetDeviceNameView: View {
    @State private var deviceName : String = ""
    //For Toast
    @State private var showToast = false
    @State var strToastMessage = ""
    @State var isMultiLine = false
    @State private var showAttendeeManifesto = false
    @State private var arrOfAttendeeStepList = [AttendeeStepListModel]()
    @State private var arrOfScreenName = [String]()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
         
            VStack(alignment: .leading, spacing: 3){
                TextFieldView(
                    title: "Device Name".localized,
                    fontSize: iPhoneFont18,
                    text: $deviceName,
                    textColor: .whiteColor,
                    isValid: .constant(true),
                    isMultiLine: $isMultiLine,
                    isTextlimitFix: false
                ) { value in
                }
                .padding(.top, 20)
                .padding(.bottom,15)
                Text("Name your child's device".localized)
                    .fontModifier(font: .montserratRegular, size: iPhoneFont18 ,color: .white)
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            .padding(.horizontal,20)
      
            Button {
               
               
            } label: {
                Text("DONE".localized)
                    .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                    .frame(height: 50)
                    .frame(maxWidth: UIScreen.screenWidth/2)
                    .background(Color.primaryBlue.cornerRadius(50))
            }
            .contentShape(Rectangle())
            .padding(.bottom, 60)
            Spacer()
        }.toast(message: strToastMessage,
                isShowing: $showToast,
                duration: ToastMessage.short)
        .customNavigationViewWithBackWidgit(title: "Time estimate".localized, color: .whiteColor)
        .background(
            LinearGradient(colors: [Color.primaryRed, Color.thirdRed],
                           startPoint: .top,
                           endPoint: .center)
        )
        //AttendeeList( title: strTitle)
   
    }
    
}
