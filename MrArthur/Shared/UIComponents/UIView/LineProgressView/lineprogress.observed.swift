//
//  AttendeeHeaderProgressBar.swift
//  MrArthur
//
//  Created by IPS-169 on 18/07/22.
//


import SwiftUI
extension AttendeeHeaderProgressBar{
    class Observed:ObservableObject{
        @Published var value: Double = 0
        let totalWidth = UIScreen.screenWidth - 40
        private let arrOfAttendeeScreenName = UtilityMethod.attendeeManifestoScreenList
        func setProgress(index: Int) {
            let numbersOfPages = arrOfAttendeeScreenName.count > 7 ? arrOfAttendeeScreenName.count  : arrOfAttendeeScreenName.count
            withAnimation {
                value = (CGFloat(index) * totalWidth) / Double(numbersOfPages)
            }
        }
        
    }
}
