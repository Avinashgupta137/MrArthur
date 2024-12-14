//
//  LineProgressView.swift
//  MrArthur
//
//  Created by IPS-169 on 07/07/22.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    static var widthOfProgerss =  UIScreen.screenWidth - 40
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(
                    width:ProgressBar.widthOfProgerss,
                    height: geometry.size.height
                )
                .opacity(0.3)
                .foregroundColor(Color(UIColor.white))
                .border(Color.primaryBlue, width: 1)
                
                Rectangle()
                    .frame(
                        width: min(CGFloat(self.value), geometry.size.width),
                        height: geometry.size.height
                    )
                    .foregroundColor(Color.primaryBlue)
                    .animation(.linear,value: value)
            }
            .cornerRadius(45.0)
        }
    }
}

struct AttendeeHeaderProgressBar: View {
    @StateObject private var manifestoLineObserverObject = Observed()
    let totalWidth = UIScreen.screenWidth - 40
    @EnvironmentObject private var attendeeManifestoObserver: AttendeeManifestoObserver
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width:totalWidth , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.clear))
                    .border(Color.primaryBlue, width: 2)
                
                Rectangle()
                    .frame(width: min(CGFloat(manifestoLineObserverObject.value), totalWidth), height: geometry.size.height)
                    .foregroundColor(Color.primaryBlue)
                    .animation(.linear,value: manifestoLineObserverObject.value)
            }
            .cornerRadius(45.0)
        }
        .onAppear {
            manifestoLineObserverObject.setProgress(index: attendeeManifestoObserver.currentIndex)
        }
        .onChange(of: attendeeManifestoObserver.currentIndex) { newValue in
            manifestoLineObserverObject.setProgress(index: attendeeManifestoObserver.currentIndex)
        }
    }
}

struct ObserverHeaderProgressBar: View {
    @State var value: Double = 0
    let totalWidth = UIScreen.screenWidth - 40
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width:totalWidth , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.clear))
                    .border(Color.primaryBlue, width: 2)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value), totalWidth), height: geometry.size.height)
                    .foregroundColor(Color.primaryBlue)
                    .animation(.linear,value: value)
            }
            .cornerRadius(45.0)
        }
        .onAppear {
            setProgress(index: observerManifestoObservedObject.currentIndex)
        }
        .onChange(of: observerManifestoObservedObject.currentIndex) { newValue in
            setProgress(index: newValue)
        }
    }
    
    private func setProgress(index: Int) {
        UserDefaultsHelper.latestStep = index
        withAnimation {
            value = (CGFloat(index) * totalWidth) / 24
        }
    }
}

struct HowItsWorkProgressBar: View {
    @State var value: Double = 0
    let totalWidth = UIScreen.screenWidth - 40
    @EnvironmentObject private var attendeeHowItWorkPageObs: AttendeeHowItWorkPageObs
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width:totalWidth , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.clear))
                    .border(Color.primaryBlue, width: 2)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value), totalWidth), height: geometry.size.height)
                    .foregroundColor(Color.primaryBlue)
                    .animation(.linear,value: value)
            }
            .cornerRadius(45.0)
        }
        .onAppear {
            setProgress(index: AttendeeHowItWorkHelper.getCurrentIndex(currentPage: attendeeHowItWorkPageObs.currentPage))
        }
        .onChange(of: attendeeHowItWorkPageObs.currentPage) { newValue in
            setProgress(index: AttendeeHowItWorkHelper.getCurrentIndex(currentPage: newValue))
        }
    }
    
    private func setProgress(index: Int) {
        withAnimation {
            value = (CGFloat(index) * totalWidth) / 7
        }
    }
}
