//
//  TextFieldView.swift
//  MrArthur
//
//  Created by Troo on 19/07/22.
//

import SwiftUI
import Combine

struct TextFieldView: View {
    
    let title: String
    let fontSize: CGFloat
    @Binding var text: String
    let textColor: Color
    @Binding var isValid: Bool
    @Binding var isMultiLine: Bool
    let isTextlimitFix : Bool
    let onChange: (String) -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.resizable) {
            Text(title)
                .fontModifier(
                    font: .montserratRegular,
                    size: fontSize,
                    color: textColor
                )
            
            TextField("", text: $text)
                .foregroundColor(Color.black)
                .disableAutocorrection(true)
                .font(
                    AppFont.MontserratRegularFont(
                        fontSize: fontSize.resizable)
                )
                .multilineTextAlignment(isMultiLine ? .center : .leading)
                .keyboardType(isMultiLine ? .decimalPad : .alphabet)
                .padding(.horizontal, 16)
                .frame(
                    height: 67.h
                )
                .background(
                    Color.white
                        .cornerRadius(34.r)
                )
                .onReceive(text.publisher.collect()) {
                        self.text = String($0.prefix(isTextlimitFix ? 20 : 500))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 34.r)
                    .stroke(
                        Color.red,
                        lineWidth: (isValid) ? 0 : 3
                    )
                )
        }
        .onChange(of: text) { newValue in
            onChange(newValue)
        }
    }
}


