//
//  CircularProgressView.swift
//  MrArthur
//
//  Created by Troo on 19/07/22.
//

import SwiftUI

struct CircularProgressView: View {
    @EnvironmentObject private var observerManifesto: ObserverManifesto
    @State private var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let lineWidth: CGFloat = 26.r
    @State private var progress: Double = 0
    @State private var counter = 0
    @State private var artificalDataProcessingImage = "MrArthurCloudFace"
    @Binding var startProgress: Bool
    let onComplete: () -> ()
    let onChange: (Int) -> ()
    var body: some View {
        ZStack {
            Image(artificalDataProcessingImage)
                .resizable()
                .scaledToFit()
                .frame(width: 133.r, height: 133.r)
            
            Circle()
                .stroke(
                    Color.lightPink,
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.primaryBlue,
                    style: StrokeStyle(
                        lineWidth: lineWidth
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
        .onAppear {
//            self.startTimer()
        }
        .onReceive(timer) { time in
            if startProgress {
                if counter == 5 {
                    stopTimer()
                    onComplete()
                    return
                }
                counter += 1
                progress = Double(counter) * 0.2
                onChange(Int(progress * 100))
                if (progress >= 0.8) {
                    artificalDataProcessingImage = "MrArthurIAQuiteHappyFace"
                }
                print("Progress vlaue \(progress)")
            }
        }
        .onChange(of: startProgress) { status in
            if status {
                self.startTimer()
            } else {
                self.stopTimer()
            }
        }
//        .onChange(of: observerManifesto.currentIndex) { newValue in
//            if newValue == 23 {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
//                    self.startTimer()
//                }
//            }
//        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    }
}
