//
//  AttendeeProfileInformationView.swift
//  MrArthur
//
//  Created by IPS-157 on 05/08/22.
//

import SwiftUI

struct AttendeeProfileInformationView: View {
    var dateFormat: String = "dd/MM/yyyy"
    @StateObject private var observed = AttendeeProfileInformationObserver()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let textColor = Color.primaryBlue
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    private let fHeight: CGFloat = .dynamicValue(
        foriPhone: 67,
        foriPad: 100
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0){
                Image(observed.attendeeAvtar)
                    .resizable()
                    .frame(
                        width: 49.r,
                        height: 49.r
                    )
                    .padding(.bottom, 24.h)
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("FIRST NAME".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: textColor
                        )
                        .padding(.bottom, 5.h)
                    
                    HStack(alignment: .center, spacing: 0){
                        EditTextView(
                            fontSize: iPhoneFont18,
                            text: $observed.attendeeName,
                            textColor: textColor,
                            isValid:.constant(true),
                            txtIsFocused: $observed.editUsername
                        ) { _ in}
                            .disabled(!observed.editUsername)
                        Spacer(minLength: 16.h)
                        
                        Button {
                            AmplitudeService.sendEvent(
                                key: .OBS_SETTING_2_EDIT_FIRST_NAME
                            )
                            observed.editUsername = true
                        } label: {
                            Image("EditIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32.r, height: 32.r)
                        }
                    }
                    .padding(.bottom, 25.h)
                    
                    Text("DATE OF BIRTH".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: textColor
                        )
                    
                    Text("DD/MM/YY".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont12,
                            color: textColor
                        )
                        .padding(.bottom, 5.h)
                    
                    HStack(alignment: .center, spacing: 0){
                        Text("\(observed.date, formatter: dateFormatter)")
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: textColor
                            )
                            .frame(width: UIScreen.screenWidth/2, height: fHeight)
                            .background(Color.white)
                            .foregroundColor(Color.secondaryBlue)
                            .cornerRadius(fHeight / 2)
                        
                        Spacer(minLength: 16.w)
                        
                        Button {
                            AmplitudeService.sendEvent(
                                key: .OBS_SETTING_2_EDIT_DOB
                            )
                            withAnimation{
                                observed.isPickerVisible = true
                            }
                        } label: {
                            Image("EditIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32.r, height: 32.r)
                        }
                        
                    }
                    
                    Spacer(minLength: 16.h)
                    
                    HStack(spacing: 0){
                        Spacer(minLength: 16.w)
                        BlueRoundedButton("Done") {
                            observed.editAttendeeAPI {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        Spacer(minLength: 16.w)
                    }
                    .padding(.bottom, 10)
                    .opacity(observed.isPickerVisible ? 0 : 1)
                }
            }
            .zIndex(1)
            
            if observed.isPickerVisible{
                VStack{
                    HStack{
                        Button {
                            observed.isPickerVisible = false
                        } label: {
                            Text("CANCEL".localized)
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont18,
                                    color: .forthRed
                                )
                        }
                        Spacer()
                        Button{
                            AmplitudeService.sendEvent(
                                key: .OBS_SETTING_2_DONE
                            )
                            observed.isPickerVisible = false
                        } label: {
                            Text("Done".localized)
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont18,
                                    color: .forthRed
                                )
                        }
                    }
                    DatePicker(
                        "",
                        selection: $observed.date,
                        in: observed.dateRange,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                }
                .padding()
                .background(Color.secondaryRed.cornerRadius(24.r))
                .zIndex(observed.isPickerVisible ? 10 : 0)
                .animation(
                    .spring(),
                    value: observed.isPickerVisible
                )
            }
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 34.h)
        .onAppear{
            observed._init()
        }
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Personal informations".localized,
            color: .white,
            amplitudeEvent: .OBS_SETTING_2_BACK
        )
        
        .background(
            LinearGradient(
                colors: [
                    Color.lightPink,
                    Color.secondaryRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

/*
struct AttendeeProfileInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeProfileInformationView()
            .multiPreview
    }
}*/
