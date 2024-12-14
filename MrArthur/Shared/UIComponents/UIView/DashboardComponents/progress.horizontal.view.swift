//
//  progress.horizontal.view.swift
//  MrArthur
//
//  Created by Troo on 29/08/22.
//

import SwiftUI

struct ProgressHorizontalView: View {
    @Binding var timeLeft: Int
    @Binding var timeSpent: Int
    @Binding var totalTime: Int
    var fHeight: CGFloat = 40
    
    @State var sTimeLeft: CGFloat = 0
    @State var sTimeSpent: CGFloat = 0
    @State var sTimeRemaining: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0){
                Rectangle()
                    .fill(Color.primaryRed)
                    .frame(
                        width: min(
                            geometry.size.width * (self.sTimeSpent),
                            geometry.size.width
                        )
                    )
                    .animation(.linear, value: self.sTimeSpent)
                Rectangle()
                    .fill(Color.primaryYellow)
                    .frame(
                        width: min(
                            geometry.size.width * (self.sTimeLeft),
                            geometry.size.width
                        )
                    )
                    .animation(.linear, value: self.sTimeLeft)
                Rectangle()
                    .fill(Color.progressGray)
                    .frame(
                        width: min(
                            geometry.size.width * (self.sTimeRemaining),
                            geometry.size.width
                        )
                    )
                    .animation(.linear, value: self.sTimeRemaining)
                
            }
            .frame(width: geometry.size.width)
            .cornerRadius(25, corners: [.topLeft, .bottomLeft])
        }
        .frame(height: fHeight.h)
        .padding(5.r)
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(24.r, corners: [.topLeft, .bottomLeft])
                .shadow(radius: 6, x: 0, y: 3)
        )
        .onAppear {
            setValues()
        }
        .onChange(of: timeSpent) { _ in
            setValues()
        }
        .onChange(of: timeLeft) { _ in
            setValues()
        }
        .onChange(of: totalTime) { _ in
            setValues()
        }
        
    }
    
    private func setValues() {
        sTimeSpent = (timeSpent > 0 && totalTime > 0) ? CGFloat((timeSpent * 100) / totalTime) / 100 : 0
        sTimeLeft = (timeLeft > 0 && totalTime > 0) ? CGFloat((timeLeft * 100) / totalTime) / 100 : 0
        let utilisedTime = sTimeSpent + sTimeLeft
        if (utilisedTime < 1) {
            sTimeRemaining = 1 - utilisedTime
        } else {
            sTimeRemaining = 0
        }
    }
}

struct ProgressHorizontalViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ProgressHorizontalView(
                timeLeft: .constant(70),
                timeSpent: .constant(100),
                totalTime: .constant(300)
            )
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.white)
    }
}
