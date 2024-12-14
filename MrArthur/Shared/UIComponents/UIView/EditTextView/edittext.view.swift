//
//  EditTextView.swift
//  MrArthur
//
//  Created by IPS-157 on 05/08/22.
//

import SwiftUI

struct EditTextView: View {
    let fontSize: CGFloat
    @Binding var text: String
    let textColor: Color
    @Binding var isValid: Bool
    @FocusState var isFocused: Bool
    @Binding var txtIsFocused: Bool
    let onChange: (String) -> ()
    
    private let fHeight: CGFloat = .dynamicValue(
        foriPhone: 67,
        foriPad: 100
    )
    var body: some View {
        VStack(alignment: .leading, spacing: 8.resizable) {
            TextField("", text: $text)
                .focused($isFocused)
                .foregroundColor(Color.primaryBlue)
                .font(AppFont.MontserratRegularFont(fontSize: fontSize.resizable))
                .padding(.horizontal, 16)
                .frame(
                    height: fHeight
                )
                .background(Color.white.cornerRadius(fHeight/2))
                .overlay(
                    RoundedRectangle(cornerRadius: fHeight / 2)
                        .stroke(Color.red, lineWidth: (isValid || text.count == 0) ? 0 : 2)
                )
        }
        .onChange(of: text) { newValue in
            onChange(newValue)
        }
        .onChange(of: txtIsFocused) { newValue in
            withAnimation {
                self.isFocused = newValue
            }
        }
    }
}
