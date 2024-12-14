//
//  attendee.content.filter.cell.view.swift
//  MrArthur
//
//  Created by BAPS on 22/11/22.
//

import SwiftUI

struct ATTContentFilterCellView: View {
    let icon: String
    let lblLevel: String
    let lblAgeGroup: String
    let clrAgeGroup: Color
    @Binding var isExpanded: Bool
    var body: some View {
        HStack(spacing: 0){
            
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(
                    width: 46.r,
                    height: 54.r
                )
                .padding(.trailing, 13.w)
            
            VStack(alignment: .leading, spacing: 8.h){
                
                Text(lblLevel)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont21,
                        color: .primaryBlue
                    )
                
                Text(lblAgeGroup)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15
                    )
                    .padding(.vertical, 5.h)
                    .padding(.horizontal, 12.w)
                    .background(clrAgeGroup.cornerRadius(16.r))
            }
            
            Spacer(minLength: 16.w)
            
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                Image(isExpanded ? "SettingsBulletCarrot2" :"SettingsBulletCarrot1")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 40.r,
                        height: 40.r
                    )
            }
        }
    }
}

struct ATTContentFilterCellView_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            ATTContentFilterCellView(
                icon: "strongShieldIcon",
                lblLevel: "Strong",
                lblAgeGroup: "BEST UNDER 7 Y.O.",
                clrAgeGroup: .primaryRed,
                isExpanded: .constant(false)
            )
            .padding()
            .background(Color.whiteColor.cornerRadius(24.r))
            Spacer()
        }
        .padding(30)
        .background(Color.forthRed)
        .multiPreview
    }
}
