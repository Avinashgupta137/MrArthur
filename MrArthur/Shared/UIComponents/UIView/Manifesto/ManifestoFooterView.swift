//
//  ManifestoFooterView.swift
//  MrArthur
//
//  Created by BAPS on 19/12/22.
//

import SwiftUI

struct ManifestoFooterView: View {
    let title: String
    let hideBackButton: Bool
    let hideNextButton: Bool
    let onBack: () -> Void
    let onNext: () -> Void
    var body: some View {
        HStack {
            if !hideBackButton {
                Button {
                    onBack()
                } label: {
                    Image.init(systemName: "arrow.backward").resizable()
                        .font(Font.title.weight(.heavy))
                        .scaledToFit()
                        .frame(width: 45.r, height: 45.r)
                        .padding(10)
                        .foregroundColor(Color.primaryBlue)
                        .overlay(
                            RoundedRectangle(cornerRadius: isiPad() ? 70 : 50)
                                .stroke(Color.primaryBlue, lineWidth: 1)
                        )
                }
                .foregroundColor(Color.primaryBlue)
                .fixedSize(horizontal: true, vertical: true)
                .contentShape(Rectangle())
                
                Spacer()
            }
            
            BlueRoundedButton(title, action: onNext)
                .opacity(hideNextButton ? 0 : 1)
                .disabled(hideNextButton)
        }
        .padding(
            EdgeInsets(
                top: 0 ,
                leading: CGFloat.dynamicValue(foriPhone: 20, foriPad: 40),
                bottom: 40,
                trailing: CGFloat.dynamicValue(foriPhone: 20, foriPad: 40)
            )
        )
        
    }
}
