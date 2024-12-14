//
//  ChildGoalSummaryView.swift
//  MrArthur
//
//  Created by Troo on 05/08/22.

import SwiftUI

struct ChildGoalSummaryView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Reduce")
                        .fontModifier(font: .montserratBold, size: iPhoneFont25)
                    
                    HStack(spacing: 0) {
                        Text(" overall screen time ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                            .background(Color.primaryRed.cornerRadius(25))
                        
                        Text(" by ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                        
                        Spacer()
                        
                    }
                    .padding(.top, 10)
                    
                    HStack(spacing: 0) {
                        Text("10%")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25, color: .primaryRed)
                        +
                        Text(" or ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                        
                        Text(" 03h00 ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont20)
                            .background(Color.primaryRed.cornerRadius(25))
                        
                        Text(" per day")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                        
                        Spacer()
                        
                    }
                    .padding(.top, 10)
                }
                .padding(.vertical, 16.resizable)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Increase")
                        .fontModifier(font: .montserratBold, size: iPhoneFont25)
                    
                    HStack(spacing: 0) {
                        Text(" educational screen time ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont22)
                            .background(Color.primaryBlue.cornerRadius(25))
                        
                        Text(" by")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                        
                        Spacer()
                        
                    }
                    .padding(.top, 10)
                    
                    HStack(spacing: 0) {
                        Text("50%")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25, color: .primaryBlue)
                        +
                        Text(" or ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                        
                        Text(" 01h00 ")
                            .fontModifier(font: .montserratBold, size: iPhoneFont20)
                            .background(Color.primaryBlue.cornerRadius(25))
                        
                        Text(" per day")
                            .fontModifier(font: .montserratBold, size: iPhoneFont25)
                        
                        Spacer()
                        
                    }
                    .padding(.top, 10)
                }
                
                
                Rectangle()
                    .fill(Color.thirdRed)
                    .frame(height: 1)
                    .padding(.vertical, 24.resizable)
                
                VStack(alignment: .leading, spacing: 5.resizable) {
                    
                    Text("WHAT YOU GET OUT OF THIS".localized)
                        .fontModifier(font: .montserratBold, size: iPhoneFont15, color: .primaryBlue)
                    
                    ChildDashboardWhatYouGetOutView()
                        .frame(height: 200.resizable)
                    
                }
                
                Rectangle()
                    .fill(Color.thirdRed)
                    .frame(height: 1)
                    .padding(.vertical, 24.resizable)

                HStack(spacing: 20) {
                    Image("MrArthurIAQuiteHappyFace")
                        .resizable()
                        .frame(width: 110.resizable, height: 110.resizable)
                    
                    Text("This first goal is pretty good! You should encourage this but try to convince USERNAME to do a little more!".localized)
                        .fontModifier(font: .montserratBoldItalic, size: iPhoneFont18, color: .primaryBlue)
                }
                Spacer(minLength: 34.resizable)
                HStack(spacing: 12) {
                    Button {
                        
                    } label: {
                        Text("IMPROVE".localized)
                            .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                            .frame(width: UIScreen.screenWidth * 0.4, height: 55.resizable)
                            .background(Color.primaryRed.cornerRadius(50))
                    }
                    
                    Button {
                        
                    } label: {
                        Text("CONFIRM".localized)
                            .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                            .frame(width: UIScreen.screenWidth * 0.4, height: 55.resizable)
                            .background(Color.primaryBlue.cornerRadius(50))
                    }
                }
                //            .padding(.vertical, 45.resizable)
                .padding(.horizontal, 19.resizable)
                
                Spacer()
            }
            .padding(.horizontal, 16.resizable)
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
        }
        .hideNavigation
        .customNavigationViewWithBack(title: "Goal summary", color: .statusBarColor)
    }
}

struct ChildGoalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ChildGoalSummaryView()
    }
}
