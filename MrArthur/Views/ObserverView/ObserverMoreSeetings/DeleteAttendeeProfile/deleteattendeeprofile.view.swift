//
//  DeleteAttendeeProfileView.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import SwiftUI

struct DeleteAttendeeProfileView: View {
    
    @StateObject var observerObject = DeleteAttendeeProfileObserved()
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @State var deleteProfile = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Text(observerObject.attendee?.attendeeName.uppercased() ?? "USERNAME")
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont18,
                    color: .primaryBlue
                )
                .padding(.bottom, 16.h)
            
            Text("You’ll lose all their data, including their screen time by deleting your child’s profile.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont18,
                    color: .primaryBlue
                )
            
            Spacer(minLength: 16.h)
            
            HStack(spacing: 0){
                
                Spacer(minLength: 16.w)
                
                Button {
                    AmplitudeService.sendEvent(
                        key: .OBS_SETTING_5_DELETE_CHILD_PROFILE
                    )
                    let deleteAttendeeparam = DeleteAttendeeRequesModel.init(attendeeUUID: UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUUID) as? String ?? "")
                    if let param = try? deleteAttendeeparam.asDictionary() {
                        observerObject.deleteAPI(withToken: ConstantOfApp.kObserverTokenSend, param: param) { message, status in
                            print("Child Deleted: \(String(describing: message)) & Status: \(status)")
                            DispatchQueue.main.async {
                                rootViewObserver.currentPage = .attendeeList
                            }
                        }
                    }
                } label: {
                    Text("DELETE CHILD’S PROFILE".localized)
                        .fontModifier(
                            font: .montserratBlack,
                            size: iPhoneFont15
                        )
                        .frame(
                            width: 341.57.w,
                            height:60.h
                        )
                        .background(
                            RoundedRectangle(
                                cornerRadius: 44.r
                            )
                            .fill(Color.primaryRed)
                        )
                }
                
                Spacer(minLength: 16.w)
            }
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 40.h)
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Delete child’s profile".localized,
            color: .white,
            amplitudeEvent: .OBS_SETTING_5_BACK
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
struct DeleteAttendeeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAttendeeProfileView()
    }
}*/
