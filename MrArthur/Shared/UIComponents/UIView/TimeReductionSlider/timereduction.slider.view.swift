//
//  TimeReductionSlider.swift
//  MrArthur
//
//  Created by IPS-169 on 03/08/22.
//

import SwiftUI

struct TimeIncreaseSlider: View {
    @Binding var position: Float
    let onChange: (Int) -> ()
    var body: some View {
        VStack(spacing: 5){
            SliderRulerView(prefix: "+")
            SliderView(position: $position, icon: "buttonSmartTimeCursor", isComeFromEducation: true, onChange: onChange)
                .frame(height: 70)
        }
    }
}

struct TimeReductionSlider: View {
    @Binding var position: Float
    let onChange: (Int) -> ()
    var body: some View {
        VStack(spacing: 5){
            SliderRulerView(prefix: "-")
            SliderView(position: $position, icon: "buttonScreenTimeCursor", isComeFromEducation: false, onChange: onChange)
                .frame(height: 70)
        }
    }
}

private struct SliderRulerView: View {
    let prefix: String
    var body: some View {
        HStack(spacing: 0) {
            Text("\(prefix)5%")
                .fontModifier(font: .montserratBold, size: iPhoneFont18, color: .primaryBlue)
            Spacer()
            Text("\(prefix)50%")
                .fontModifier(font: .montserratBold, size: iPhoneFont18, color: .primaryBlue)
        }
        .padding(.horizontal ,40)
    }
}

private struct SliderView: View {
    let totalPercentage: Float = 45
    @Binding var position: Float
    let icon: String
    let isComeFromEducation: Bool
    let onChange: (Int) -> ()
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 14)
                    .cornerRadius(26)
                    .zIndex(5)
                Rectangle()
                    .foregroundColor(isComeFromEducation ? Color.white : Color.white)
                    .frame(width: geometry.size.width * CGFloat(self.position / 100), height: 14)
                    .cornerRadius(26)
                    .zIndex(5)
                
                Image(icon)
                    .frame(width: 67, height: 67)
                    .padding(.leading, (geometry.size.width * CGFloat(self.position / 100)) - 32)
                    .zIndex(6)
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    self.position = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                    setPercentage()
                }))
        }
        .padding(.horizontal ,50)
        .onAppear{
            setPercentage(onAppear: true)
        }
        .onChange(of: position) { newValue in
            setPercentage()
        }
    }
    
    private func setPercentage(onAppear: Bool = false) {
        let currentPercentage = Int(((totalPercentage*position)/100)) + 5
        if !onAppear{
            onChange(currentPercentage)
        }
    }
}
