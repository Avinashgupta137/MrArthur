//
//  AttendeeCreateGoalView.swift
//  MrArthur
//
//  Created by Troo on 03/08/22.
// Move the cursor forward to reduce your screen time.

import SwiftUI

struct AttendeeCreateGoalView: View {
    
    @StateObject private var createAttendeeGoalObservedObject = CreateAttendeeGoal()
    @State var position : Float = 0
    @State var increaseEducationTime =  false
    @Binding var rootIsActive : Bool
    @State var reduceScreenTime = 0
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Move the cursor forward to".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont25
                            )
                        
                        HStack(spacing: 0) {
                            Text("reduce ".localized)
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont25
                                )
                            
                            Text(" your screen time.".localized)
                                .fontModifier(
                                    font: .montserratBold,
                                    size: iPhoneFont25
                                )
                                .background(Color.primaryRed.cornerRadius(24.r))
                            Spacer()
                        }
                    }
                    .padding(.bottom, 24.h)
                    
                    VStack(spacing: 7.h) {
                        Text(createAttendeeGoalObservedObject.reducedTime)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont20
                            )
                            .frame(width: 122.w, height: 44.h)
                            .background(
                                Color.primaryRed.cornerRadius(24.r)
                            )
                        
                        Text("Total screen time\nper day".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont12,
                                color: .primaryBlue
                            )
                            .multilineTextAlignment(.center)
                    }
                    
                    TimeReductionSlider(position: $position) { percentage in
                        print("TimeReductionSlider \(percentage)")
                        createAttendeeGoalObservedObject.setTime(percentage: percentage)
                    }
                    
                    Rectangle()
                        .fill(Color.whiteColor)
                        .frame(height: 1.h)
                        .padding(.vertical, 18.resizable)
                    
                    VStack(alignment: .leading, spacing: 5.h) {
                        Text("WHAT YOU GET OUT OF THIS".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                        HStack(spacing: 5) {
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoBook",
                                title: createAttendeeGoalObservedObject.titleComic,
                                subTitle: "per year".localized
                            )
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoBike",
                                title: createAttendeeGoalObservedObject.titleRide,
                                subTitle: "bike trips".localized
                            )
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoFriendsMovie",
                                title: createAttendeeGoalObservedObject.titleAfternoon,
                                subTitle: "with friends".localized
                            )
                        }
                        Spacer()
                    }
                    
                    Rectangle()
                        .fill(Color.whiteColor)
                        .frame(height: 1.h)
                        .padding(.vertical, 18.h)
                    
                    HStack(spacing: 0) {
                        createAttendeeGoalObservedObject.getImageByPercentage()
                            .resizable()
                            .frame(
                                width: 110.r,
                                height: 110.r
                            )
                        
                        Spacer(minLength: 20.w)
                        
                        VStack(alignment: .leading, spacing: 0){
                            Text(createAttendeeGoalObservedObject.getTextByPercentage().localized)
                                .fontModifier(
                                    font: .montserratExtraBoldItalic,
                                    size: iPhoneFont18,
                                    color: .primaryBlue
                                )
                                .minimumScaleFactor(0.1)
                        }
                    }
                    
                    Spacer(minLength: 16.h)
                    
                    HStack(spacing: 16.h) {
                        BlueRoundedButton("IMPROVE", color: .primaryRed) {
                            self.position = 45.8
                            increaseEducationTime = true
                            AmplitudeService.sendEventWithData(
                                key: .ATT_CO_3_3_IMPROVE,
                                data: ["reduceScreenTimeInPercentage" : reduceScreenTime]
                            )
                        }
                        BlueRoundedButton("CONFIRM") {
                            increaseEducationTime = true
                            AmplitudeService.sendEventWithData(
                                key: .ATT_CO_3_3_CONFIRM,
                                data: ["reduceScreenTimeInPercentage" : reduceScreenTime]
                            )
                        }
                    }
                }
            }
            NavigationLink(
                "",
                destination:
                    AttendeeCreateGoalIncreaseView(
                        reducedScreenTimePercentage: createAttendeeGoalObservedObject.reducedPercentage,
                        iReducedTime: createAttendeeGoalObservedObject.iReducedTime,
                        rootIsActive: $rootIsActive
                    ) ,
                isActive: $increaseEducationTime
            )
            .isDetailLink(false)
            .labelsHidden()
        }
        .padding(.top, 20.h)
        .padding(.horizontal, 24.w)
        .hideNavigation
        .statusBarStyle(color: .statusBarColor)
        .background(
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        Gradient.Stop(
                            color: .lightPink, location: 0.5
                        ),
                        Gradient.Stop(
                            color: .secondaryRed, location: 0.9
                        ),
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}


//struct AttendeeCreateGoalView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeCreateGoalView(rootIsActive: .constant(true))
//            .multiPreview
//    }
//}
