//
//  ManifestoImageView.swift
//  MrArthur
//
//  Created by Troo on 28/07/22.
//

import SwiftUI

struct ManifestoImageView: View {
    let image: String
    var bottomPadding: CGFloat = 16
    var imageHeightRatio: CGFloat = 0.40
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
//            .padding(.vertical, 40.h)
            .frame(
                width: UIScreen.screenWidth,
                height: (ScreenUtils.heightByScreenPercent(50) - statusBarHeight)
            )
            .background(Color.secondaryRed)
    }
}
