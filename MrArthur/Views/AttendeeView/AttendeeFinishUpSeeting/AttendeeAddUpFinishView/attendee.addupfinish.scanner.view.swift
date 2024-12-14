//
//  attendee.addupfinish.scanner.view.swift
//  MrArthur
//
//  Created by IPS-157 on 29/08/22.
//

import SwiftUI

struct AttendeeAddupfinishScannerView: View {
    @State private var addUpFinish = false
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                VStack(alignment: .leading, spacing: 24.h){
                    Text("Well done!".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont25,
                            color: .primaryBlue
                        )
                    if UtilityMethod.isFrench{
                        Group{
                            Text("RDV sur l’App Store ou scannez le QR code directement avec l’appareil de votre enfant pour y installez l’app ")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("mr.arthur !")
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("\n\nVous pourrez vous identifier avec l’e-mail que vous avez renseigné à la création de votre compte. ")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                    } else{
                        Group{
                            Text("Now it’s time to install ")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("mr.arthur ")
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("app on your child’s device. ".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("ATTD_SCANNER_SIGNIN_WITH".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("ATTD_SCANNER_YOUR".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("ATTD_SCANNER_ACC_EMAIL".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                        
                        Group{
                            Text("You can get ".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("mr.arthur ")
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                            +
                            Text("from the App Store or scan this code with the child’s device.")
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                        }
                    }
                }
                
                Spacer(minLength: 16.h)
                
                Image(uiImage: UIImage(data: UtilityMethod.getQRCodeDate(text: ConstantOfApp.kAppUrl)!)!)
                    .resizable()
                    .scaledToFit()
                    .padding(24.r)
                    .frame(width: 251.r, height: 251.r)
                    .background(Color.white.cornerRadius(46.r))
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton("NEXT") {
                    addUpFinish = true
                    AmplitudeService.sendEvent(
                        key: .OBS_ADD_UP_FINISH_NEXT
                    )
                }
            }
            NavigationLink(
                "",
                destination: AttendeeAddupFinishFinalView(),
                isActive: $addUpFinish
            )
            .labelsHidden()
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 32.w)
        .frame(width: UIScreen.screenWidth)
        
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "DEVICE_OWNER".localized,
            color: .white,
            amplitudeEvent: .OBS_ADD_UP_FINISH_BACK
        )
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
        .edgesIgnoringSafeArea(.all)
    }
}

/*
struct AttendeeAddupfinishScannerView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeAddupfinishScannerView(scannerImage: "DemoScanner")
            .multiPreview
    }
}*/
