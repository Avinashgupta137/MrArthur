//
//  low.content.filterselection.view.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//• no downtime period • explicit music, book, web allowed • TV - 14 / Movie - R • adult content blocked • app 17+ (app install upon request) • social media compatible

import SwiftUI

struct LowContentFilterSelectionView: View {
    @State private var isLowLevel = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isSelected : Bool
    let onTap:  ()->()
    var body: some View {
        VStack(spacing: 0){
            
            ATTContentFilterCellView(
                icon: "lowShieldIcon",
                lblLevel: "Low".localized,
                lblAgeGroup: "BEST FOR 12 TO 17 Y.O.".localized,
                clrAgeGroup: .validateGreen,
                isExpanded: $isLowLevel
            )
            
            if isLowLevel {
                Rectangle()
                    .foregroundColor(.primaryRed.opacity(0.3))
                    .frame(height: 2)
                    .cornerRadius(2)
                    .padding(.vertical, 22.h)
            }
            
            VStack(spacing : 0) {
                VStack(alignment: .leading, spacing : 16.h){
                    ContentIntroductionView(
                        contentTitle: "• explicit music, book, web allowed".localized,
                        contentImage: "SettingsFilteringDetailsGreen03",
                        contentColor : .validateGreen
                    )
                    ContentIntroductionView(
                        contentTitle: "• TV - 14  / Movie - R".localized,
                        contentImage: "SettingsFilteringDetailsGreen04",
                        contentColor : .validateGreen
                    )
                    ContentIntroductionView(
                        contentTitle: "• adult content blocked".localized,
                        contentImage: "SettingsFilteringDetailsRed05",
                        contentColor : .forthRed
                    )
                    ContentIntroductionView(
                        contentTitle: "• app 17+ (app install upon request)".localized,
                        contentImage: "contentFilteringAppIcon",
                        contentColor : .primaryBlue
                    )
                    ContentIntroductionView(
                        contentTitle: "• social media compatible".localized,
                        contentImage: "socialShieldGreen",
                        contentColor : .validateGreen
                    )
                }
                .padding(.horizontal,24.w)
                
                
                BlueRoundedButton(
                    "CHOOSE",
                    width: 225.46
                ) {
                    withAnimation {
                        isLowLevel.toggle()
                    }
                    onTap()
                }
                .padding(.vertical, 44.h)
            }
            .frame(height: isLowLevel ? nil : 0)
            .clipped()
        }
        .padding(.vertical, 16.h)
        .padding(.horizontal, 18.w)
        .background(Color.whiteColor.cornerRadius(28.r))
        .overlay(
            RoundedRectangle(
                cornerRadius: 28.r
            )
            .inset(by: 1)
            .stroke(Color.validateGreen, lineWidth: 3.h)
            .opacity(isSelected ? 1 : 0)
        )
    }
}

//struct LowContentFilterSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            LowContentFilterSelectionView(
//                isSelected: .constant(false),
//                onTap: {}
//            )
//            Spacer()
//        }
//        .padding(30)
//        .background(Color.forthRed)
//    }
//}
