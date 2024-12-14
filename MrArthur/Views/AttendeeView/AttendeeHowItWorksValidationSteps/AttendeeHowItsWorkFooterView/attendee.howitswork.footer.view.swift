//
//  attendee.howitswork.footer.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 02/11/22.
//

import SwiftUI

struct AttendeeHowItsWorkFooterView: View {
    
    let buttonSize : CGFloat = isiPad() ? 70 : 50
    let imageButton : CGFloat = isiPad() ? 50 : 30
    @State private var isActive = false
    @EnvironmentObject private var attendeeHowItWorkPageObs: AttendeeHowItWorkPageObs
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    var body: some View {
        HStack {
            Button {
                if attendeeHowItWorkPageObs.currentPage == .CONGRATS{
                    rootViewObserver.currentPage = .attendeeTabBar
                } else{
                    attendeeHowItWorkPageObs.currentPage = AttendeeHowItWorkHelper.getPrevious(
                        currentPage: attendeeHowItWorkPageObs.currentPage
                    )
                }
            } label: {
                Image.init(systemName: "arrow.backward")
                    .resizable()
                    .font(Font.title.weight(.heavy))
                    .scaledToFit()
                    .frame(
                        width:imageButton,
                        height:imageButton
                    )
                    .padding(10)
                    .foregroundColor(Color.primaryBlue)
                    .overlay(
                        RoundedRectangle(cornerRadius:isiPad() ? 70 : 50)
                            .stroke(Color.primaryBlue, lineWidth: 1)
                    )
            }
            .foregroundColor(Color.primaryBlue)
            .fixedSize(horizontal: true, vertical: true)
            .contentShape(Rectangle())
            
            Spacer()
            
            BlueRoundedButton(getNextButtonLabel()){
                AttendeeHowItWorkHelper.callAPI(stepname: attendeeHowItWorkPageObs.currentPage) { error, model in
                    if let error = error, !error.isEmpty {
                        // do error oprations
                    } else if let _ = model {
                        if attendeeHowItWorkPageObs.currentPage != .LOOK_AT_DASHBOARD {
                            attendeeHowItWorkPageObs.currentPage = AttendeeHowItWorkHelper.getNext(
                                currentPage: attendeeHowItWorkPageObs.currentPage
                            )
                        } else {
                            if var attendee = UserDefaultsHelper.selectedAttendee {
                                attendee.attendeeUserManifesto?.done = true
                                UserDefaultsHelper.selectedAttendee = attendee
                                rootViewObserver.currentPage = .attendeeTabBar
                            }
                        }
                    }
                }
            }
        }
        .padding(
            EdgeInsets(
                top: 0 ,
                leading: 20,
                bottom: 40,
                trailing: 20)
        )
        
        NavigationLink(
            destination: ObserverManifestoMainView(),
            isActive: $isActive,
            label: {}
        )
        .labelsHidden()
    }
    
    private func getNextButtonLabel() -> String {
        if attendeeHowItWorkPageObs.currentPage == .LOOK_AT_DASHBOARD{
            return "OK"
        }else{
            return "NEXT"
        }
    }
}
