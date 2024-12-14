//
//  AttendeeCreateGoalIncreaseView.swift
//  MrArthur
//
//  Created by Troo on 09/08/22.
//

import SwiftUI
import RichText

struct AttendeeCreateGoalIncreaseView: View {
    
    let reducedScreenTimePercentage: Int
    let iReducedTime: Int
    @Binding var rootIsActive : Bool
    @StateObject private var educationGoalObject = AttendeeEducation()

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    RichText(html: educationGoalObject.getHtmlString())
                        .fontType(.customName("Montserrat-Bold"))
                        .customCSS(UtilityMethod.goalCss)
                    
                    Group {
                        HStack(alignment: .top, spacing: 0){
                            VStack (spacing: 5.h) {
                                Text(educationGoalObject.sEducationScreenTimePerDay)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont20
                                    )
                                    .frame(width: 122.w, height: 44.h)
                                    .background(
                                        Color.primaryBlue.cornerRadius(24.r)
                                    )
                                
                                Text("Educational screen\ntime per day".localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont12,
                                        color: .primaryBlue
                                    )
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 122.w)
                            
                            Rectangle()
                                .frame(width: 1.h, height: 44.h)
                                .rotationEffect(.degrees(30))
                                .padding(.horizontal, 34.w)
                            
                            VStack (spacing: 5.h) {
                                Text(educationGoalObject.sTotalScreenTimePerDay)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont20
                                    )
                                    .frame(width: 122.w,height: 44.h)
                                    .background(Color.primaryRed.cornerRadius(24.r))
                                Text("Total screen time\nper day".localized)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: iPhoneFont12,
                                        color: .primaryBlue
                                    )
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 122.w)
                            
                        }
                    }
                    .padding(.bottom, 27.h)
                    
                    TimeIncreaseSlider(position: $educationGoalObject.position) { percentage in
                        educationGoalObject.setTime(percentage: percentage)
                    }
                    
                    Rectangle()
                        .fill(Color.whiteColor)
                        .frame(height: 1.h)
                        .padding(.vertical, 18.h)
                    
                    VStack(alignment: .leading, spacing: 5.h) {
                        Text("WHAT YOU GET OUT OF THIS".localized)
                            .fontModifier(
                                font: .montserratExtraBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                        HStack(spacing: 0) {
                            AttendeeDashboardWhatYouGetOutCardCenterView(
                                icon: "FomoForeignLanguage",
                                title: "1 new language".localized,
                                subTitle: educationGoalObject.totalNewLang
                            )
                            Spacer()
                            AttendeeDashboardWhatYouGetOutCardRightView(
                                icon: "FomoImpressedFriend",
                                title: "14 very\nimpressed friends".localized,
                                subTitle: "per year".localized
                            )
                        }
                    }
                    
                    Rectangle()
                        .fill(Color.whiteColor)
                        .frame(height: 1.h)
                        .padding(.vertical, 24.h)
                    
                    HStack(spacing: 0) {
                        educationGoalObject.getImageByPercentage()
                            .resizable()
                            .frame(
                                width: 110.r,
                                height: 110.r
                            )
                        
                        Spacer(minLength: 20.w)
                        
                        Text(educationGoalObject.getTextByPercentage().localized)
                            .fontModifier(
                                font: .montserratExtraBoldItalic,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                            .minimumScaleFactor(0.1)
                    }
                    
                    Spacer(minLength: 16.h)
                    
                    BlueRoundedButton("CONFIRM") {
                        let increaseEducationTime = educationGoalObject.iIncreasedTime
                        AmplitudeService.sendEventWithData(
                            key: .ATT_CO_3_CONFIRM,
                            data: [
                                "increaseEducationTime" : increaseEducationTime
                            ]
                        )
                        educationGoalObject.isActive = true
                    }
                }
                NavigationLink(
                    "",
                    destination: FinalGoalScreenView(
                        reducedScreenTimePercentage: reducedScreenTimePercentage,
                        increasedEducationTimePercentage: educationGoalObject.iIncreasedPercentage,
                        increasedEducationTime: educationGoalObject.sEducationScreenTimePerDay,
                        reducedScreenTime: educationGoalObject.sTotalScreenTimePerDay,
                        shouldPopToRootView: $rootIsActive
                    ),
                    isActive: $educationGoalObject.isActive
                )
                .isDetailLink(false)
            }
        }
        .onAppear {
            educationGoalObject._init(iTotalScreenTimeReduced: self.iReducedTime)
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


struct AttendeeCreateGoalIncreaseView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeCreateGoalIncreaseView(
            reducedScreenTimePercentage: 20,
            iReducedTime: 123,
            rootIsActive: .constant(true)
        )
        .multiPreview
    }
}
