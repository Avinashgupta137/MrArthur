//
//  ParentDashboardView.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//

import SwiftUI

struct ParentDashboardView: View {
    
    @State private var isGoal = false
    
    let beforeGoal = "before goal"
    let afterGoal = "after goal"
    
    @State private var childAvtarImage = "iconAvatarProfileGirl"
    @State var showGoalSummary = false
    @State var showSetting = false
    @State private var statusOfMeditation = ConstantOfApp.knotcreated
    
    @StateObject var observerParentObject = ParentObserver()
    @StateObject var selectedChildObject = selectedChildDynamicData()
    
    
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                    
                    HStack(spacing: 0){
                        Image(selectedChildObject.getchildImage())
                            .resizable()
                            .frame(width: UIScreen.screenWidth * 0.15, height: UIScreen.screenWidth * 0.15)
                            .padding(.trailing, 12.65)
                        Text(selectedChildObject.childname.localized)
                            .fontModifier(font: .montserratBold, size: iPhoneFont18, color: .primaryBlue)
                        Spacer()
                     /*   Image("iconGear")
                            .resizable()
                            .frame(width: UIScreen.screenWidth * 0.1, height: UIScreen.screenWidth * 0.1)*/
                        Button {
                            showSetting = true
                        } label: {
                            Image("iconGear")
                                .resizable()
                                .frame(width: UIScreen.screenWidth * 0.1, height: UIScreen.screenWidth * 0.1)
                        }
                    
                    }
                    .padding(.bottom, 20.resizable)
                    
                    ZStack(alignment: .topLeading){
                        Circle()
                            .fill(isGoal ? Color.validateGreen : Color.forthRed)
                            .frame(width: 25.resizable, height: 25.resizable)
                            .overlay(
                                Circle()
                                    .stroke(Color.secondaryRed, lineWidth: isiPad() ? 5 : 3)
                            )
                            .zIndex(1)
                        HStack(alignment: .bottom, spacing: 5) {
                            VStack(alignment: .leading, spacing: isiPad() ? 10 : 5){
                                Text("Sunday 06 June")
                                    .fontModifier(font: .montserratRegular, size: iPhoneFont13, color: .primaryBlue)
                                Text("Your child has 24 hours to send you, their goals. Make sure you follow up! You’ll be notified as your joint efforts progress.".localized)
                                    .fontModifier(font: .montserratRegular, size: iPhoneFont15, color: .primaryBlue)
                                if(statusOfMeditation == ConstantOfApp.knotcreated){
                                    
                                }else{
                                Button {
                                    showGoalSummary = true
                                } label: {
                                    Text("SEE MY GOAL".localized)
                                        .fontModifier(font: .montserratBold, size: iPhoneFont15)
                                        .frame(width: UIScreen.screenWidth * 0.45, height: 60.resizable)
                                        .background(Color.primaryBlue.cornerRadius(50))
                                }
                                .contentShape(Rectangle())
                                }
                                Spacer()
                            }
                            .padding(.top, 13.resizable)
                            .padding(.leading, 27.resizable)
                            Spacer()
                            Image("DashboardNotificationSandtimer")
                                .resizable()
                                .frame(width: UIScreen.screenWidth * 0.1, height: UIScreen.screenHeight * 0.1)
                                .padding(.trailing, 27.resizable)
                                .padding(.bottom, 20.resizable)
                        }
                        .frame(width: UIScreen.screenWidth - 48, height: UIScreen.screenHeight * 0.2)
                        .background(Color.secondaryRed.cornerRadius(((UIScreen.screenHeight * 0.09) / 2)))
                        .overlay(
                            RoundedRectangle(cornerRadius: (UIScreen.screenHeight * 0.05))
                                .stroke((isGoal ? Color.validateGreen : Color.forthRed), lineWidth: isiPad() ? 5 : 3)
                        )
                    }
                    .padding(.bottom, 35.resizable)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Usage report".localized)
                            .fontModifier(font: .montserratBlack, size: iPhoneFont25, color: .primaryBlue)
                        
                        Rectangle()
                            .fill(Color.lightPink)
                            .frame(height: isiPad() ? 2 : 1)
                            .padding(.bottom, 10.resizable)
                        
                        HStack(spacing: 0){
                            VStack(alignment: .leading, spacing: 0){
                                Text("AVERAGE SCREEN TIME PER DAY".localized)
                                    .fontModifier(font: .montserratBold, size: iPhoneFont15, color: .primaryBlue)
                                Text((isGoal ? afterGoal : beforeGoal).localized)
                                    .fontModifier(font: .montserratBold, size: iPhoneFont15, color: (isGoal ? Color.validateGreen : Color.forthRed))
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $isGoal)
                                .labelsHidden()
                                .toggleStyle(
                                    ColoredToggleStyle(
                                        onColor: .validateGreen,
                                        offColor: .forthRed
                                    )
                                )
                                .scaleEffect( isiPad() ? 1.5 : 1)
                        }
                        .padding(.bottom, 25.5.resizable)
                        
                        HStack(spacing: 10) {
                            Text("04")
                                .fontModifier(font: .montserratBold, size: iPhoneFont50, color: .primaryBlue)
                                .frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.1)
                                .background(Color.white.cornerRadius((UIScreen.screenWidth * 0.3) / 2))
                            Text("h")
                                .fontModifier(font: .montserratRegular, size: iPhoneFont40, color: .primaryBlue)
                            Text("35")
                                .fontModifier(font: .montserratBold, size: iPhoneFont50, color: .primaryBlue)
                                .frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.1)
                                .background(Color.white.cornerRadius((UIScreen.screenWidth * 0.3) / 2))
                            Spacer()
                        }
                        
                    }
                    
                    Rectangle()
                        .fill(Color.lightPink)
                        .frame(height: isiPad() ? 2 : 1)
                        .padding(.vertical, 30.resizable)
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        
                        HStack(spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("DAILY DEVICES".localized)
                                    .fontModifier(font: .montserratBold, size: iPhoneFont15, color: .primaryBlue)
                                
                                Text("CONSUMPTION ESTIMATIONS".localized)
                                    .fontModifier(font: .montserratBold, size: iPhoneFont15, color: .primaryBlue)
                                
                                Text((isGoal ? afterGoal : beforeGoal).localized)
                                    .fontModifier(font: .montserratBold, size: iPhoneFont15, color: (isGoal ? Color.validateGreen : Color.forthRed))
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $isGoal)
                                .labelsHidden()
                                .toggleStyle(
                                    ColoredToggleStyle(
                                        onColor: .validateGreen,
                                        offColor: .forthRed
                                    )
                                )
                                .scaleEffect( isiPad() ? 1.5 : 1)
                        }
                        .padding(.bottom, 10)
                        //
                        Line()
                            .stroke(
                                Color.white,
                                style: StrokeStyle(lineWidth: 3, dash: [15,10])
                            )
                            .frame(width: 65, height: 3)
                            .padding(.bottom, 3)
                        
                        Text("PUBLIC HEALTH RECOMMENDATIONS".localized)
                            .fontModifier(font: .montserratBold, size: iPhoneFont12)
                            .padding(.bottom, 10)
                        
                        HStack{
                            Spacer()
                            BarChartView(
                                data:
                                    [
                                        BarChartData(seconds: 10800, recommendation: 9000,color: .primaryBlue, icon: "iconSmartphone"),
                                        BarChartData(seconds: 15000, recommendation: 10000,color: .forthRed, icon: "GameConsol"),
                                        BarChartData(seconds: 8000, recommendation: 6000,color: .primaryBlue, icon: "iconTV"),
                                        BarChartData(seconds: 7500, recommendation: 5000,color: .forthRed, icon: "iconPad"),
                                        BarChartData(seconds: 6000, recommendation: 4000,color: .primaryBlue, icon: "iconDesktop")
                                    ]
                            )
                                .frame(width: (UIScreen.screenWidth * (isiPad() ? 0.6 : 0.8)), height: UIScreen.screenHeight * (isiPad() ? 0.45 : 0.4), alignment: .bottom)
                            Spacer()
                        }
                        //                        .background(Color.red)
                        //                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 35)
                    
                    Rectangle()
                        .fill(Color.lightPink)
                        .frame(height: 1)
                        .padding(.bottom, 26)
                    
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("BREAKDOWN OF ACTIVITIES PER DAY".localized)
                                    .fontModifier(font: .montserratBold, size: 15, color: .primaryBlue)
                                
                                Text((isGoal ? afterGoal : beforeGoal).localized)
                                    .fontModifier(font: .montserratBold, size: 15, color: (isGoal ? Color.validateGreen : Color.forthRed))
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $isGoal)
                                .labelsHidden()
                                .toggleStyle(
                                    ColoredToggleStyle(
                                        onColor: .validateGreen,
                                        offColor: .forthRed
                                    )
                                )
                                .scaleEffect( isiPad() ? 1.5 : 1)
                        }
                        
                        .padding(.bottom, 25)
                        
                        CircularChartView(chartData: $observerParentObject.chartData)
                        
                    }
                    .padding(.bottom, 16)
                    
                    Spacer()
                }.onAppear {
                
                                    statusOfMeditation = UtilityMethod().getvalueforkey(key: ConstantOfApp.kstatusOfMeditation) as? String ?? ConstantOfApp.knotcreated
                                }
                .padding(24)
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            stops: [
                                Gradient.Stop(color: .secondaryRed, location: 0),
                                Gradient.Stop(color: .lightPink, location: 0.5),
                                Gradient.Stop(color: .secondaryRed, location: 0.9),
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                NavigationLink("", destination: ParentGoalSummaryView(), isActive: $showGoalSummary)
                NavigationLink("", destination: ParentMoreView(), isActive: $showSetting)
            }
            .hideNavigation
            .customNavigationView(title: "Dashboard", color: .navigationBarColor)
        }.navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func setData() {
        
    }
}

struct ParentDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ParentDashboardView()
    }
}
