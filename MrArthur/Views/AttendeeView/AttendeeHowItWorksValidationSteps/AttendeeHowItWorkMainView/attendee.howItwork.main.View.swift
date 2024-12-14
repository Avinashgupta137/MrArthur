//
//  attendee.howItwork.main.View.swift
//  MrArthur
//
//  Created by Nirav Patel on 17/10/22.
//

import SwiftUI

struct AttendeeHowItworkMainView: View {
    var body: some View {
        LoadingView {
            ZStack(alignment: .topLeading){
                VStack{
                    AttendeeHowItsWorkHeaderSectionView()
                        .padding(.top, 16)
                        .statusBarStyle(color: .white)
                    Spacer()
                    AttendeeHowItsWorkFooterView()
                }
                .zIndex(10)
                AttendeeHowitworkContextView()
            }
        }
        .hideNavigation
        .ignoresSafeArea()
    }
}
