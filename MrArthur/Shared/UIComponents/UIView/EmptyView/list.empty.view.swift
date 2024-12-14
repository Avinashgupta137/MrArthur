//
//  list.empty.view.swift
//  MrArthur
//
//  Created by BAPS on 18/01/23.
//

import SwiftUI

struct ListEmptyView: View {
    var title: String = "Sorry!"
    let message: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title.localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: 25.sp,
                    color: .primaryBlue
                )
                .padding(.bottom, 10.h)
            Text(message.localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: 18.sp,
                    color: .primaryBlue
                )
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                Image("ic_empty_view")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300.r, height: 300.r)
                Spacer()
            }
            Spacer()
        }
        .padding(32.r)
        .frame(width: UIScreen.screenWidth)
        .background(Color.secondaryRed)
    }
}
