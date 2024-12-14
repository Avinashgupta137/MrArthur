//
//  attendee.dashboard.date.view.swift
//  MrArthur
//
//  Created by Troo on 31/08/22.
//

import SwiftUI

struct AttendeeDashboardDateView: View {
    let dateString: String
    
    @State var weekDay: String = EWeekDay.MONDAY.rawValue
    @State var dateMonth: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5.h) {
                Text(weekDay.capitalizingFirstLetter())
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont25,
                        color: .primaryBlue
                    )
                Text(dateMonth)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
            }
            
            Spacer(minLength: 16.w)
            
            Image("AttendeeDashboardMrArthurHand")
                .resizable()
                .frame(width: 153.w, height: 40.h)
                .padding(.vertical, 24.h)
        }
        .padding(.leading, 21.w)
        .background(Color.white.cornerRadius(20.r))
        .onAppear {
            setData()
        }
    }
    
    private func setData() {
        if let value = DateService.shared
            .getWeekDayFromDateString(
                dateString: dateString
            ) {
            self.weekDay = value
        }
        
        self.dateMonth = DateService.shared
            .getStringDateWithSuffixfromDateString(
                dateString: dateString
            )
            .uppercased()
        
        print("Date Month :\( self.dateMonth)")
        let newDate = self.dateMonth
        let frenchDateArr : [String] = newDate.components(separatedBy: " ")
        var firstName : String = frenchDateArr[0]
        var secondName : String = frenchDateArr[1]
        let characters = Array(firstName)
        print("Characters: \(characters)")
        let filterDate = firstName.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        print(firstName.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined())
        var frenchDate = ""
        frenchDate.append(filterDate)
        frenchDate.append("\(" ")")
        frenchDate.append(secondName)
        if UtilityMethod.isFrench{
            self.dateMonth = frenchDate
        }
    }
}

struct AttendeeDashboardDateViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AttendeeDashboardDateView(dateString: "06/09/2022")
            Spacer()
        }
        .padding()
        .background(Color.secondaryRed)
    }
}
