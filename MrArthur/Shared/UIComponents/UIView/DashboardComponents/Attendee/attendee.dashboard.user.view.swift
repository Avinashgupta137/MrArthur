//
//  attendee.dashboard.user.view.swift
//  MrArthur
//
//  Created by Troo on 31/08/22.
//

import SwiftUI

struct AttendeeDashboardUserView: View {
    let attendeeUser : AttendeeListResponseModel = UserDefaultsHelper.selectedAttendee ?? AttendeeListResponseModel()
    
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_QUARTER_ON_GOING,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTQuarterOnGoing: Int = 0
    
    @State var changeTrophyColor : Bool = false
    var body: some View {
        HStack(spacing: 10.w) {
            Image(attendeeUser.avtar)
                .resizable()
                .frame(width: 55.r, height: 55.r)
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text("Hello,".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                
                HStack(spacing: 0) {
                    Text(attendeeUser.attendeeName)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    Spacer()
                    Image(changeTrophyColor ? "AttendeeDashboardCupSmallYellow" : "AttendeeDashboardCupSmallBlue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15.r, height: 15.r)
                        .padding(.trailing, 5.w)
                    Text("\(educationalSTQuarterOnGoing)")
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont10,
                            color: .primaryBlue
                        )
                }
            }
        }
        .onAppear{
            setValues()
        }
        .onChange(of: educationalSTQuarterOnGoing) { _ in
            setValues()
        }
    }
    private func setValues() {
        if educationalSTQuarterOnGoing >= 1{
            changeTrophyColor = true
        } else {
            changeTrophyColor = false
        }
    }
}

struct AttendeeDashboardUserViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AttendeeDashboardUserView()
            Spacer()
        }
        .padding()
        .background(Color.secondaryRed)
    }
}
