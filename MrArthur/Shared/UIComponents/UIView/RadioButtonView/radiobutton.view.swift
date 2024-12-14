//
//  RadioButtonView.swift
//  MrArthur
//
//  Created by Troo on 19/07/22.
//

import SwiftUI

struct RadioButtonView: View {
    
    let title: String
    let fontSize: CGFloat
    @Binding var selected: Bool
    let onSelect: ()->()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.h){
            Text(title)
                .fontModifier(
                    font: .montserratRegular,
                    size: fontSize,
                    color: .primaryBlue
                )
            Button {
                onSelect()
            } label: {
                Circle()
                    .fill(selected ? Color.primaryBlue : Color.white)
                    .frame(width: 67.r, height: 67.r)
            }
            .contentShape(Rectangle())
        }
    }
}
