//
//  AttendeeProfileDetailView.swift
//  MrArthur
//
//  Created by IPS-157 on 05/08/22.
//

import SwiftUI

struct AttendeeProfileDetailView: View {
    var body: some View {
        VStack(spacing: 0){
            NavigationLink(
                destination: AttendeeProfileInformationView()
            ) {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true ,
                    buttonTitle: "PERSONAL INFORMATIONS".localized
                )
            }
            NavigationLink(
                destination: AttendeeDeviceView()
            ) {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true,
                    buttonTitle: "DEVICES".localized
                )
            }
            NavigationLink(
                destination: DeleteAttendeeProfileView()
            ) {
                MoreCardSectionView(
                    buttonImage: "chevron.forward",
                    isSystemImage: true,
                    buttonTitle: "REMOVE THIS CHILD’S PROFILE".localized
                )
            }
            
            Spacer(minLength: 16.h)
        }
        .padding(24.h)
        .customNavigationViewWithBackWidgit(
            title: "Child’s profile".localized,
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

//struct AttendeeProfileDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeProfileDetailView()
//            .multiPreview
//    }
//}
