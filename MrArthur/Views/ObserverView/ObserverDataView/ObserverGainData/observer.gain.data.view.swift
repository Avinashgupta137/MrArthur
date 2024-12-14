//
//  observer.gain.data.view.swift
//  MrArthur
//
//  Created by IPS-157 on 07/09/22.
//

import SwiftUI
import UIKit
import Macaw

struct ObserverGainDataView: View {
    @StateObject private var observer = ObserverGainDataObserver()
    @State private var totalGainData : Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Group{
                        Text("mr.arthur ".localized)
                            .fontModifier(
                                font: .montserratBlack,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                        +
                        Text("sparks a love of learning in your child!".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont22,
                                color: .primaryBlue
                            )
                    }
                    Spacer()
                }
                .padding(.bottom, 30.h)
                EducationScreenTime(
                    svgName: UtilityMethod.isFrench ? "educationFileFrench" : "educationFile",
                    size: CGSize(width: (UIScreen.screenWidth - 48), height: 450.h),
                    timeInMin : observer.timeInMin,
                    timeInYear: observer.timeInYear
                )
                .scaledToFit()
                .padding(24.h)
                .background(Color.white.cornerRadius(32.r))
                .padding(.bottom, 16.h)
                
                HStack(spacing: 0){
                    Text("Based on your answers. With a 20% educational goal assumption (20% of remaining screen time after reduction).".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryBlue
                        )
                    Spacer()
                }
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton("NEXT") {
                    totalGainData = true
                    AmplitudeService.sendEvent(key: .OBS_DATA_GAIN_01_NEXT)
                }
            }
            NavigationLink(
                "",
                destination: OBSGainDataTotalTimeView(),
                isActive: $totalGainData
            )
        }
        .padding(.horizontal, 24.w)
        .padding(.vertical, 38.h)
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "",
            color: .white,
            amplitudeEvent: .OBS_DATA_GAIN_01_BACK,
            showBackButton: false
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct EducationScreenTime: UIViewRepresentable {
    var svgName: String
    let size: CGSize
    var timeInMin: Int
    var timeInYear: Int
    
    func makeUIView(context: Context) -> SVGView {
        if let node = try? SVGParser.parse(resource: svgName) {
            let svgView = SVGView(node: node, frame: CGRect(origin: CGPoint.zero, size: size))
            svgView.backgroundColor = UIColor.clear
            return svgView
        }
        return SVGView()
    }
    func updateUIView(_ uiView: SVGView, context: Context) {
        let font20 = Font(
            name : Bundle.main.path(
                forResource: "Montserrat-Bold",
                ofType: "ttf"
            )!,
            size : 20,
            weight : "bold"
        )
        
        let font15 = Font(
            name : Bundle.main.path(
                forResource: "Montserrat-Bold",
                ofType: "ttf"
            )!,
            size : 15,
            weight : "bold"
        )
        
        if let lblDiscoverMin = uiView.node.nodeBy(tag: "educ_start_time") as? Macaw.Text {
            lblDiscoverMin.font = font20
            lblDiscoverMin.text = "\(timeInMin) min"
            lblDiscoverMin.place = .init(1, 0, 0, 1, 191.600, 467)
        }
        
        if let lblLearn = uiView.node.nodeBy(tag: "educ_language_time") as? Macaw.Text {
            lblLearn.font = font15
            lblLearn.text = "120 h"
            lblLearn.place = .init(1, 0, 0, 1, 222, 461)
        }
        
        if let lblLearnH = uiView.node.nodeBy(tag: "educ_year_time") as? Macaw.Text {
            lblLearnH.font = font20
            lblLearnH.text = "120 h"
            lblLearnH.place = .init(1, 0, 0, 1, 200, 467)
        }
    }
}

/*
struct ObserverGainDataView_Previews: PreviewProvider {
    static var previews: some View {
        ObserverGainDataView(
            timeInMin: .constant(15),
            timeInYear: .constant(200)
        )
            .multiPreview
    }
}*/
