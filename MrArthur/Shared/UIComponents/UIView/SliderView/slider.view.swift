//
//  SliderView.swift
//  MrArthur
//
//  Created by Troo on 20/07/22.
//

import SwiftUI

struct CustomSliderView: View {
    @State private var currentValue : Double = 0
    let onChange: (Int) -> ()
    var body: some View {
        VStack(spacing: 25.5){
            SliderRulerView()
            SliderView(
                value: $currentValue,
                sliderRange: 0...32,
                onChange: onChange
            )
        }.padding(.horizontal, CGFloat.dynamicValue(foriPhone: 32, foriPad: 80))
        .frame(height: 150.h)
    }
}

private struct SliderRulerView: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 0) {
                RulerTextView(value: "0")
                Spacer()
                RulerTextView(value: "2")
                Spacer()
                RulerTextView(value: "4")
                Spacer()
                RulerTextView(value: "6")
                Spacer()
                RulerTextView(value: "8")
            }
            HStack(spacing: 0) {
                Group{
                    RulerLineView(height: 30)
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                }
                Group{
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                    Spacer()
                    RulerLineView(height: 15)
                }
                Group{
                    Spacer()
                    RulerLineView(height: 30)
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                }
                Group{
                    Spacer()
                    RulerLineView(height: 15)
                    Spacer()
                    RulerLineView(height: 30)
                }
            }
            .padding(.horizontal, CGFloat.dynamicValue(
                foriPhone: 10,
                foriPad: 16
            ))
        }
    }
}

private struct RulerTextView: View {
    let value: String
    
    var body: some View {
        Group{
            Text(value)
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont18,
                    color: .primaryBlue
                )
            +
            Text("H")
                .fontModifier(
                    font: .montserratBold,
                    size: iPhoneFont12,
                    color: .primaryBlue
                )
        }
    }
}

private struct RulerLineView: View {
    let height: CGFloat
    var body: some View {
        Rectangle()
            .foregroundColor(.primaryBlue)
            .frame(width: 2, height: height)
            .cornerRadius(0.5)
    }
}


private struct SliderView: View {
    @Binding var value: Double
    var totalSteps = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210, 225, 240, 255, 270, 285, 300, 315, 330, 345, 360, 375, 390, 405, 420, 435, 450, 465, 480]
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 0...100
    var thumbColor: Color = .yellow
    var minTrackColor: Color = .forthRed
    var maxTrackColor: Color = .primaryBlue
    @State var timeValue = ""
    let onChange: (Int) -> ()
    private let sliderHeight: CGFloat = CGFloat.dynamicValue(foriPhone: 15, foriPad: 20)
    var body: some View {
        GeometryReader { gr in
            let minValue = 0.0
            let maxValue = gr.size.width - CGFloat.dynamicValue(foriPhone: 20, foriPad: 40)
            let scaleFactor = maxValue / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(height: sliderHeight)
                    .cornerRadius(6)
                    .padding(.horizontal, CGFloat.dynamicValue(
                        foriPhone: 10,
                        foriPad: 16
                    ))
                HStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(minTrackColor)
                        .frame(width: sliderVal, height: sliderHeight)
                    Spacer()
                }
                .cornerRadius(6)
                
                
                HStack(spacing: 0) {
                    ZStack{
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors:
                                            [
                                                .primaryBlue,
                                                .forthRed
                                            ]
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        Text(timeValue)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont20
                            )
                    }
                    .frame(
                        width: CGFloat.dynamicValue(foriPhone: 67, foriPad: 115),
                        height: CGFloat.dynamicValue(foriPhone: 67, foriPad: 115)
                    )
                    .offset(x: sliderVal - CGFloat.dynamicValue(
                        foriPhone: 20,
                        foriPad: 35
                    ))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { v in
                                checkTime()
                                if (abs(v.translation.width) < 0.1) {
                                    self.lastCoordinateValue = sliderVal
                                }
                                if v.translation.width > 0 {
                                    let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                    self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                } else {
                                    let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                    self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                }
                            }
                    )
                    Spacer()
                }
            }
        }
        .onAppear{
            checkTime()
        }
        
    }
    private func checkTime() {
        let currentMinutes = totalSteps[Int(value)]
        let (h,m,_) = UtilityMethod.minutesToHoursMinutesSeconds(currentMinutes)
        if (m) > 10{
            self.timeValue = "\(h)H\(m)"
        }
        else{
            self.timeValue = "\(h)H0\(m)"
        }
        onChange(currentMinutes)
    }
}
