//
//  AttStartScreen.swift
//  MrArthur
//
//  Created by IPS-169 on 31/08/22.
//

import SwiftUI

struct AttendeeStartScreen: View {
    var userRole = UtilityMethod().getValueForKey(key: ConstantOfApp.kCurrentUserRole) as? String ?? ""
    @EnvironmentObject private var rootViewObserver : RootViewObserver
    @EnvironmentObject private var attendeeManifestoObservedObject : AttendeeManifestoObserver
    @EnvironmentObject private var loaderObserver: LoaderObserver
    
    @State var toastMessage: String = ""
    @State var showToast: Bool = false
    
    var body: some View {
        LoadingView {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading,spacing: 32.h) {
                        Text("Congrats!".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size:  iPhoneFont25
                            )
                        
                        Text("Your part is over for now, you can give your child his phone back and ask him to follow the onboarding !".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size:  iPhoneFont25
                            )
                        
                        Group{
                            Text("If your child has another phone or tablet you need to install ".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont25
                                )
                            +
                            Text("mr.arthur".localized)
                                .fontModifier(
                                    font: .montserratBlack,
                                    size: iPhoneFont25
                                )
                            +
                            Text(", the setup will be faster!".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont25
                                )
                        }
                    }
                }
                
                Spacer(minLength: 16.h)
                
                Image("AttendeeRelay")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 153.w,
                        height: 265.h
                    )
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton("OK") {
                    AmplitudeService.sendEvent(
                        key: .ATT_START_INTRO_2_OK
                    )
                    loaderObserver.showLoader = true
                    if(userRole == ConstantOfApp.kCurrentUserAttendee){
                        loaderObserver.showLoader = false
                        UserDefaultsHelper.appUserType = .attendee
                        let param = [String:Any]()
                        LoginHelper().attendeeLoginAPICall(param: param) { value in
                            print(value)
                            if let data = value as? (manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
                                loaderObserver.showLoader = false
                                rootViewObserver.currentPage = data.rootScreen
                                attendeeManifestoObservedObject.currentIndex = data.manifestoIndex
                                
                            }else if let data = value as? ERootView{
                                loaderObserver.showLoader = false
                                print("else Redirect to \(value)")
                                rootViewObserver.currentPage = data
                            }
                        } failure: { errmsg in
                            loaderObserver.showLoader = false
                            print("failure \(errmsg)")
                            toastMessage = errmsg
                            showToast = true
                        }
                    }
                }
            }
        }
        .padding(.vertical, 34.h)
        .padding(.horizontal, 24.w)
        .statusBarStyle(color: .statusBarColor)
        .hideNavigation
        .toast(
            message: toastMessage,
            isShowing: $showToast,
            duration: ToastMessage.short
        )
        .edgesIgnoringSafeArea(.all)
        .background(
            LinearGradient(
                colors: [
                    Color.primaryRed,
                    Color.thirdRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        
    }
}
/*
struct AttendeeStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeStartScreen()
            .multiPreview
    }
}
*/
