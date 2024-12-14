//
//  AttendeeGoalSummaryView.swift
//  MrArthur
//
//  Created by Troo on 05/08/22.

import SwiftUI
import RichText

struct ObserverGoalSummaryView: View {
    @StateObject var observer = ObserverGoalSummaryObserver()
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var iReducedTotalScreenTimePercent : Int
    @Binding var iEducationalTotalScreenTimePercent : Int
    @Binding var sReducedTotalScreenTime : String
    @Binding var sEducationalTotalScreenTime : String
    @Binding var comic : String
    @Binding var bikeTrip: String
    @Binding var movies: String
    @Binding var mrArthurImage : String
    @Binding var mrArthurMessage : String
    
    var body: some View {
        LoadingView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    RichText(html: observer.getHtmlString(
                        rPercentage: iReducedTotalScreenTimePercent,
                        rDuration: sReducedTotalScreenTime,
                        ePercentage: iEducationalTotalScreenTimePercent,
                        eDuration: sEducationalTotalScreenTime
                    ))
                    .fontType(.customName("Montserrat-Bold"))
                    .customCSS(UtilityMethod.goalCss)
                    .padding(.top, 8.h)
                    
                    
                    Rectangle()
                        .fill(Color.whiteColor)
                        .frame(height: 1.h)
                        .padding(.vertical, 24.h)
                    
                    VStack(alignment: .leading, spacing: 12.h) {
                        Text("WHAT YOU GET OUT OF THIS".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont15,
                                color: .primaryBlue
                            )
                        HStack(spacing: 5) {
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoBook",
                                title: "\(comic)",
                                subTitle: "per year".localized
                            )
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoBike",
                                title: "\(bikeTrip)",
                                subTitle: "bike trips".localized
                            )
                            AttendeeDashboardWhatYouGetOutCardView(
                                icon: "FomoFriendsMovie",
                                title: "\(movies)",
                                subTitle: "with friends".localized
                            )
                        }
                    }
                    
                    Rectangle()
                        .fill(Color.whiteColor)
                        .frame(height: 1)
                        .padding(.top, 20.h)
                        .padding(.bottom, 38.h)
                    
                    HStack(spacing: 20) {
                        Image(mrArthurImage)
                            .resizable()
                            .frame(width: 110.r, height: 110.r)
                        
                        Text(mrArthurMessage)
                            .fontModifier(
                                font: .montserratBoldItalic,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        
                    }
                    
                    Spacer(minLength: 32.h)
                    
                    HStack(spacing: 16.w) {
                        Button {
                            loaderObserver.showLoader = true
                            AmplitudeService.sendEvent(
                                key: .OBS_CO_3_REFUSE
                            )
                            observer.approveMediation(status: false) { status, message,approveMediationrespone in
                                loaderObserver.showLoader = false
                                if (status == true){
                                    UtilityMethod().saveInDefault(value: ConstantOfApp.kMediationRejected, key: ConstantOfApp.kStatusOfMeditation)
                                    presentationMode.wrappedValue.dismiss()
                                }
                                else{
                                    print("Message: \(message)")
                                }
                            }
                        } label: {
                            Text("REFUSE".localized)
                                .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                                .frame(width: 184.w, height: 60.h)
                                .background(Color.primaryRed.cornerRadius(50))
                        }
                        .contentShape(Rectangle())
                        
                        Button {
                            loaderObserver.showLoader = true
                            AmplitudeService.sendEvent(
                                key: .OBS_CO_3_ACCEPT
                            )
                            observer.approveMediation(status: true) { status, message,approveMediationrespone in
                                loaderObserver.showLoader = false
                                if (status == true){
                                    UtilityMethod().saveInDefault(value: ConstantOfApp.kMediationApproved, key: ConstantOfApp.kStatusOfMeditation)
                                    presentationMode.wrappedValue.dismiss()
                                }
                                else{
                                    print("Message: \(message)")
                                }
                            }
                        } label: {
                            Text("ACCEPT".localized)
                                .fontModifier(font: .montserratBlack, size: iPhoneFont15)
                                .frame(width: 184.w, height: 60.h)
                                .background(Color.primaryBlue.cornerRadius(50))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 24.w)
                .padding(.bottom, 32.h)
            }
        }
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Goal summary".localized,
            color: .whiteColor,
            amplitudeEvent: .OBS_CO_3_BACK
        )

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
        .edgesIgnoringSafeArea(.all)
    }
}

/*
struct ObserverGoalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ObserverGoalSummaryView(
            iReducedTotalScreenTimePercent : .constant(10),
            iEducationalTotalScreenTimePercent : .constant(10),
            sReducedTotalScreenTime : .constant("00h00"),
            sEducationalTotalScreenTime : .constant("00h00"),
            comic : .constant(10),
            bikeTrip : .constant(10),
            movies : .constant(10),
            mrArthurImage : .constant("MrArthurIANotHappyAtAllFace"),
            mrArthurMessage : .constant("It’s just not enough...your parents will never accept this !")
        )
        .multiPreview
    }
}*/
