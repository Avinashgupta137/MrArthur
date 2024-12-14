//
//  strong.content.filterselection.view.swift
//  MrArthur
//
//  Created by IPS-157 on 31/08/22.
//

//• downtime period (preset 21h-7h, can be modified)
//• explicit not allowed
//• TV - G / Movie - G
//• adult content blocked
//• app 9+ (app install upon request)
//• no social media

import SwiftUI

struct StrongContentFilterSelectionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isStrongLevel = false
    let isSelected : Bool
    let onTap: ()->()
    var body: some View {
        VStack(spacing: 0) {
            
            ATTContentFilterCellView(
                icon: "strongShieldIcon",
                lblLevel: "Strong".localized,
                lblAgeGroup: "BEST UNDER 7 Y.O.".localized,
                clrAgeGroup: .primaryRed,
                isExpanded: $isStrongLevel
            )
            
            if isStrongLevel {
                Rectangle()
                    .foregroundColor(.primaryRed.opacity(0.3))
                    .frame(height: 2)
                    .cornerRadius(2)
                    .padding(.vertical, 22.h)
            }
            
            VStack(spacing : 0) {
                VStack(alignment: .leading, spacing : 16.h){
                    
                    ContentIntroductionView(
                        contentTitle: "• explicit not allowed".localized,
                        contentImage: "SettingsFilteringDetailsRed03",
                        contentColor : .forthRed
                    )
                    ContentIntroductionView(
                        contentTitle: "• TV - G / Movie - G".localized,
                        contentImage: "SettingsFilteringDetailsGreen04",
                        contentColor : .validateGreen
                    )
                    ContentIntroductionView(
                        contentTitle: "• adult content blocked".localized,
                        contentImage: "SettingsFilteringDetailsRed05",
                        contentColor : .forthRed
                    )
                    ContentIntroductionView(
                        contentTitle: "• app 9+ (app install upon request)".localized,
                        contentImage: "contentFilteringAppIcon",
                        contentColor : .primaryBlue
                    )
                    ContentIntroductionView(
                        contentTitle: "• no social media".localized,
                        contentImage: "socialShieldRed",
                        contentColor : .primaryRed
                    )
                }
                .padding(.horizontal,24.w)
                
                
                BlueRoundedButton(
                    "CHOOSE",
                    width: 225.46
                ) {
                    withAnimation {
                        isStrongLevel.toggle()
                    }
                    onTap()
                }
                .padding(.vertical, 44.h)
            }
            .frame(height: isStrongLevel ? nil : 0)
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


//struct StrongContentFilterSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            StrongContentFilterSelectionView(
//                isSelected: true,
//                onTap: {}
//            )
//            Spacer()
//        }
//        .padding(30)
//        .background(Color.forthRed)
//        .multiPreview
//    }
//}
