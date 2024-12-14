//
//  AnswerTileView.swift
//  MrArthur
//
//  Created by Troo on 13/07/22.
//

import SwiftUI

struct AnswerTileView: View {
    @StateObject private var observed = Observed()
    @Binding var isActiveAnswer: Bool
    let title: String
    let onTap: ()->()
    var body: some View {
        Button {
            self.isActiveAnswer = true
            onTap()
            
        } label: {
            HStack(spacing: 0) {
                Spacer(minLength: 16.w)
                Text(title.localized)
                    .fontModifier(
                        font: isActiveAnswer ? .montserratBold : .montserratRegular,
                        size: iPhoneFont18,
                        color: isActiveAnswer ? .white : .primaryBlue
                    )
                    .multilineTextAlignment(.center)
                Spacer(minLength: 16.w)
            }
                .frame(height: 67.h)
        }
        .contentShape(Rectangle())
        .background(isActiveAnswer ? Color.primaryBlue : Color.white)
        .cornerRadius(34.r)
    }
}
