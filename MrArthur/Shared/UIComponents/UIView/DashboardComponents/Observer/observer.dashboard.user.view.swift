//
//  observer.dashboard.user.view.swift
//  MrArthur
//
//  Created by Troo on 29/08/22.
//

import SwiftUI

struct ObserverDashboardUserView: View {
    @Binding var totalSavedSecondScreenTime: Int
    @Binding var multiDeviceEducationalQuarterReached: Int
    @State var changeTrophyColor : Bool = false
    let attendee: AttendeeListResponseModel
    let attendeeProfile: () -> ()
    let attendeeList: () -> ()
    var body: some View {
        HStack(spacing: 0) {
            Button {
                AmplitudeService.sendEvent(
                    key: .OBS_SIGN_IN_USER_CHOICE_2_BACK
                )
                attendeeList()
            } label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 25.r, weight: .bold))
                    .foregroundColor(Color.primaryBlue)
            }
            .contentShape(Rectangle())
            
            
            Rectangle()
                .fill(Color.lightPink)
                .frame(width: 1.w, height: 34.h)
                .padding(.trailing, 36.w)
                .padding(.leading, 16.w)
            
            VStack(spacing: 5) {
                HStack(spacing: 0) {
                    Button(action: attendeeProfile) {
                        ZStack(alignment: .topLeading){
                            Image(attendee.avtar)
                                .resizable()
                                .frame(width: 55.r, height: 55.r)
                                .padding(.leading, 5)
                            Image("iconGear")
                                .resizable()
                                .frame(width: 18.5.r, height: 18.5.r)
                                .padding(1.r)
                                .background(Color.secondaryRed.cornerRadius(9.r))
                        }
                    }
                    .buttonStyle(.plain)
                    .containerShape(Rectangle())
                    
                    Spacer()
                    
                    VStack(spacing: 7.h) {
                        Text("Total time saved".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont12,
                                color: .validateGreen
                            )
                        HStack(spacing: 0) {
                            Image("DashboardTimeSavedIcon")
                                .resizable()
                                .frame(width: 25.w, height: 21.h)
                            
                            Spacer()
                            
                            Text("\(self.computeTotalTimeSaveFromSecond(second: totalSavedSecondScreenTime))")
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont20
                                )
                        }
                        .padding(.vertical, 3.h)
                        .padding(.horizontal, 12.w)
                        .frame(width: 123.w)
                        .background(Color.validateGreen.cornerRadius(24.r))
                    }
                }
                
                HStack(spacing: 5.w) {
                    Text(attendee.attendeeName)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                    
                    Spacer()
                    
                    Image(changeTrophyColor ? "AttendeeDashboardCupSmallYellow" : "AttendeeDashboardCupSmallBlue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15.w, height: 14.h)
                    
                    Text("\(multiDeviceEducationalQuarterReached)")
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
        .onChange(of: multiDeviceEducationalQuarterReached) { _ in
            setValues()
        }
    }
    private func setValues() {
        if multiDeviceEducationalQuarterReached >= 1{
            changeTrophyColor = true
        }
        else{
            changeTrophyColor = false
        }
    }
    public func computeTotalTimeSaveFromSecond(second: Int) -> String {
        let (h, m) = (second / 3600, (second % 3600) / 60)
        let minute: String = m < 10 ? "0\(m)" : "\(m)"
        return "\(h)h\(minute)"
    }
}


struct ObserverDashboardUserView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            ObserverDashboardUserView(
                totalSavedSecondScreenTime: .constant(120),
                multiDeviceEducationalQuarterReached: .constant(120),
                attendee: AttendeeListResponseModel(),
                attendeeProfile: {},
                attendeeList: {}
            )
            Spacer()
        }
        .padding(.horizontal, 24.w)
        .background(Color.primaryRed)
        .multiPreview
    }
}
