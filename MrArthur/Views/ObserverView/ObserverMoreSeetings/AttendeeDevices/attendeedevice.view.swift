//
//  AttendeeDeviceView.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import SwiftUI

struct AttendeeDeviceView: View {
   
    let devices = UserDefaultsHelper.selectedAttendee?.deviceList ?? []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0){
                ForEach(devices) { device in
                    Text(device.label)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                        .padding(.top, 20.h)

                    Rectangle()
                        .fill(Color.thirdRed)
                        .frame(height: 1.h)
                        .padding(.top, 20.h)
                }
                
                Spacer(minLength: 16.h)
            }
        }
        .padding(.horizontal, 24.w)
        .padding(.top, 30.h)
        .customNavigationViewWithBackWidgit(
            title: "Devices".localized,
            color: .whiteColor
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

//struct AttendeeDeviceView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeDeviceView()
//            .multiPreview
//    }
//}
