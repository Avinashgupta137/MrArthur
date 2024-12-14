//
//  ToggleStyles.swift
//  MrArthur
//
//  Created by Troo on 27/07/22.
//

import SwiftUI

struct ColoredToggleStyle: ToggleStyle {
    let onColor: Color
    let offColor: Color
    
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(Color.white)
                .frame(width: 50, height: 29)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? onColor : offColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .animation(Animation.easeInOut(duration: 0.1), value: configuration.isOn)
        }
        .buttonStyle(.plain)
    }
}

struct OverlayToggleStyle: ToggleStyle {
    let color:Color
    func makeBody(configuration: Self.Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .stroke(
                    color,
                    lineWidth: 1
                )
                .frame(width: 50, height: 29)
                .overlay(
                    Group {
                        if configuration.isOn {
                            Circle()
                                .fill(color)
                                .frame(width: 22, height: 22)
                                .shadow(radius: 0, x: 0, y: 0)
                                .padding(1.5)
                                .offset(x: configuration.isOn ? 10 : -10)
                        } else {
                            Circle()
                                .stroke(
                                    color,
                                    lineWidth: 1
                                )
                                .frame(width: 22, height: 22)
                                .shadow(radius: 0, x: 0, y: 0)
                                .padding(2)
                                .offset(x: configuration.isOn ? 10 : -10)
                        }
                    }
                )
                .animation(Animation.easeInOut(duration: 0.1), value: configuration.isOn)
        }
        .contentShape(Rectangle())
        .buttonStyle(.plain)
    }
}
