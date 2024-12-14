//
//  medium.content.filterselection.view.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//• downtime period (preset 22h-6h, can me modified) • explicit not allowed • TV - PG / Movie - PG • adult content blocked • app 17+ (app install upon request) • social media compatible

import SwiftUI

struct MediumContentFilterSelectionView: View {
    @State private var isMediumLevel = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isSelected : Bool
    let onTap: ()->()
    var body: some View {
        VStack(spacing: 0) {
            
            ATTContentFilterCellView(
                icon: "mediumShieldIcon",
                lblLevel: "Medium".localized,
                lblAgeGroup: "BEST FOR 7 TO 12 Y.O.".localized,
                clrAgeGroup: .primaryOrange,
                isExpanded: $isMediumLevel
            )
            
            if isMediumLevel {
                Rectangle()
                    .foregroundColor(.primaryRed.opacity(0.3))
                    .frame(height: 2)
                    .cornerRadius(2)
                    .padding(.vertical, 22.h)
            }
            
            VStack(spacing : 0) {
                VStack(alignment: .leading, spacing : 16.h) {
                    ContentIntroductionView(
                        contentTitle: "• explicit not allowed".localized,
                        contentImage: "SettingsFilteringDetailsRed03",
                        contentColor : .forthRed
                    )
                    ContentIntroductionView(
                        contentTitle: "• TV - PG / Movie - PG".localized,
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
                        isMediumLevel.toggle()
                    }
                    onTap()
                }
                .padding(.vertical, 44.h)
                
            }
            .frame(height: isMediumLevel ? nil : 0)
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


//struct MediumContentFilterSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            MediumContentFilterSelectionView(
//                isSelected: .constant(false),
//                onTap: {}
//            )
//            Spacer()
//        }
//        .padding(30)
//        .background(Color.forthRed)
//    }
//}
