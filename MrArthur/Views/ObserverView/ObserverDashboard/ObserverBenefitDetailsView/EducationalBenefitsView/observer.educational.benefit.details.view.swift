//
//  observer.benefit.details.view.swift
//  MrArthur
//
//  Created by Troo on 02/09/22.
//

import SwiftUI

struct ObserverEducationalBenefitDetailsView: View {
    @StateObject var observer = OBSBenefitDetailsObserver()
    @State private var rect: CGRect = .zero
    @State var hideImage : Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing:0) {
            Text("Collect them all!".localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
                .padding(.bottom, 16.h)
            Group {
                Text("Collect & share with your loved ones your ".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                +
                Text(UtilityMethod.isFrench ? "" : "mr.arthur ".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                +
                Text("performance and benefits!".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
            }
            .padding(.bottom, 24.h)
            
            ZStack(alignment: .top) {
                Image(UtilityMethod.isFrench ? "DashboardCollectableCardN01French" : "DashboardCollectableCardN01")
                    .resizable()
                VStack(spacing: 0){
                    HStack(spacing: 0) {
                        Spacer()
                        Button {
                            AmplitudeService.sendEvent(
                                key: .OBS_DASH_BENEFITS_01_SHARE
                            )
                            hideImage = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if let image = UIApplication
                                    .shared
                                    .keyWindow?
                                    .rootViewController?.view
                                    .asImage(rect: self.rect) {
                                    shareCard(image: image)
                                    hideImage = false
                                }
                            }
                        } label: {
                            Image("buttonShare")
                                .resizable()
                                .frame(width: 40.r, height: 40.r)
                                .shadow(radius: 6, x: 0, y: 3)
                        }
                        .contentShape(Rectangle())
                        .opacity(hideImage ? 0 : 1)
                    }
                    .padding(.top, 16.h)
                    .padding(.trailing, 24.w)
                    
                    Spacer()
                    Group{
                        Text("At this pace,\n".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text(" \(observer.userName.uppercased()) ")
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text("will learn \na new language \nin".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text(" \(observer.totalDay) ")
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text("days!".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.screenWidth * 0.6)
                    .rotationEffect(.degrees(-8))
                    .padding(.bottom, UtilityMethod.isFrench ? 40 : 65)
                }
            }
            .background(RectGetter(rect: $rect))
            .padding(.bottom, 24.h)
            .padding(.horizontal, 6.w)
            
            Spacer()
        }
        .padding(.top, 32.w)
        .padding(.horizontal, 24.w)
        .frame(width: UIScreen.screenWidth)
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "Benefits".localized,
            color: .white,
            backTitle: "Dashboard".localized,
            amplitudeEvent: .OBS_DASH_BENEFITS_01_BACK
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .center
            )
        )
        .edgesIgnoringSafeArea(.all)
        
    }
    private func shareCard(image: UIImage){
        let cardImage = image
        let shareAll = [ cardImage ] as [Any]
        
        AppShared.shareSheet(items: shareAll)
    }
}

struct ObserverBenefitDetailsViewPreviews: PreviewProvider {
    static var previews: some View {
        ObserverEducationalBenefitDetailsView()
    }
}
