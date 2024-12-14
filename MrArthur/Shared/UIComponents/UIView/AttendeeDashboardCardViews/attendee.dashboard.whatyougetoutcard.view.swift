//
//  attendeedashboardwhatyougetoutcard.view.swift
//  MrArthur
//
//  Created by Troo on 02/08/22.
//

import SwiftUI

struct AttendeeDashboardWhatYouGetOutCardView: View {
    let icon: String
    let title: String
    let subTitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            HStack(spacing: 0){
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 5)
                Spacer()
            }
            Spacer()
            Text(title.localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont13,
                    color: .primaryBlue
                )
            Text(subTitle.localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont13,
                    color: .primaryBlue
                )
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white.cornerRadius(33.r))
        
    }
}

struct AttendeeDashboardWhatYouGetOutCardRightView: View {
    let icon: String
    let title: String
    let subTitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            HStack{
                Spacer()
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 5)
            }
            Spacer()
            Text(title.localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont13,
                    color: .primaryBlue
                )
            HStack {
                Text(subTitle.localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont13,
                        color: .primaryBlue
                    )
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white.cornerRadius(33))
        
    }
}
struct AttendeeDashboardWhatYouGetOutCardCenterView: View {
    let icon: String
    let title: String
    let subTitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            HStack(alignment: .center){
                Spacer()
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.bottom, 5)
                Spacer()
            }
            Spacer()
            Text(title.localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont13,
                    color: .primaryBlue
                )
            HStack {
                Text(subTitle.localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont13,
                        color: .primaryBlue
                    )
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white.cornerRadius(33))
        
    }
}

struct AttendeeDashboardWhatYouGetOutCardRightView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            AttendeeDashboardWhatYouGetOutCardRightView(
                icon: "FomoBook",
                title: "14 very\nimpressed friends".localized,
                subTitle: "per year".localized
            )
            .frame(width: 120.w, height: 160.h)
            Spacer()
        }
        .fullScreenFrame
        .background(Color.primaryRed)
    }
}
