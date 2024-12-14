//
//  SwiftUIView.swift
//  MrArthur
//
//  Created by Amit Sinha on 15/11/22.
//

import SwiftUI

struct ObserverTimeSavedScreenBenefitView: View {
    @StateObject var observer = OBSBenefitTimeDetailsObserver()
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
            
            ZStack(alignment: .bottom) {
                Image(UtilityMethod.isFrench ? "DashboardCollectableCardN02French" : "DashboardCollectableCardN02")
                    .resizable()
                VStack{
                    HStack(spacing: 0) {
                        Spacer()
                        Button {
                            AmplitudeService.sendEvent(
                                key: .OBS_DASH_BENEFITS_01_2_SHARE
                            )
                            hideImage = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if let image = UIApplication.shared.windows.first?
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
                        Text("\(self.computeTotalTimeSaveFromSecond(second: observer.totalSecondSavedFromBeginning)) ")
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text("hours of real life\n".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text("back for".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text(" \(observer.userName.uppercased()) !\n")
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                        +
                        Text("More family time or more time with friends !".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont18,
                                color: .primaryBlue
                            )
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.screenWidth * 0.6)
                    .rotationEffect(.degrees(-8))
                    .padding(.bottom, UtilityMethod.isFrench ? 25 : 30)
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
            amplitudeEvent: .OBS_DASH_BENEFITS_01_2_BACK
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
        let shareAll = [cardImage] as [Any]
        
        AppShared.shareSheet(items: shareAll)
    }
    public func computeTotalTimeSaveFromSecond(second: Int) -> String {
        let (h, m) = (second / 3600, (second % 3600) / 60)
        let minute: String = m < 10 ? "0\(m)" : "\(m)"
        return "\(h)h\(minute)"
    }
}

