//
//  blue.rounded.button.swift
//  MrArthur
//
//  Created by BAPS on 31/10/22.
//

import SwiftUI

struct BlueRoundedButton: View {
    let label: String
    let labelFontStyle: FontStyle
    let labelFontSize: CGFloat
    let width: CGFloat
    let height: CGFloat
    let cornorRadius: CGFloat
    let color: Color
    let action: () -> ()
    
    init(
        _ label: String,
        labelFontStyle: FontStyle = .montserratBlack,
        labelFontSize: CGFloat = iPhoneFont15,
        width: CGFloat = 184.14,
        height: CGFloat = 60,
        color: Color = .primaryBlue,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.labelFontStyle = labelFontStyle
        self.labelFontSize = labelFontSize
        self.width = width
        self.height = height
        self.cornorRadius = height * 0.5
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(label.localized)
                .fontModifier(
                    font: labelFontStyle,
                    size: labelFontSize
                )
                .frame(
                    width: width.sp,
                    height: height.h
                )
                .background(
                    RoundedRectangle(cornerRadius: cornorRadius.r)
                    .fill(color)
                )
        }
        .contentShape(Rectangle())
    }
}
