//
//  DatePickerView.swift
//  MrArthur
//
//  Created by Troo on 20/07/22.
//

import SwiftUI

struct CustomDatePickerView: View {
    var title: String
    @Binding var date: Date?
    var dateFormat: String = "dd/MM/yyyy"
    var dateString : String = "DD/MM/YY"
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    @Binding var showPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.h){
            Text(title)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont18,
                    color: .primaryBlue
                )
            
            Text(dateString.localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont12,
                    color: .primaryBlue
                )
            Button {
                showPicker = true
                UIApplication.shared.endEditing()
            } label: {
                Group {
                    if date != nil {
                        Text("\(date!, formatter: dateFormatter)")
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont22,
                                color: .secondaryBlue
                            )
                    } else {
                        Text("Select".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont22,
                                color: .black
                            )
                    }
                }
                .frame(
                    width: 190.sp,
                    height: 67.h
                )
                .background(
                    Color.white
                        .cornerRadius(34.r)
                )
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
        }
    }
}

struct DatePickerView: View {
//    @State private var date = Date.now.addingTimeInterval(-86400)
    @State private var date = Date.now.addingTimeInterval(-86400)
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let start = calendar.date(
            byAdding: .year,
            value: -30,
            to: Date.now
        ) ?? Date.now
        let end = calendar.date(
            byAdding: .day,
            value: -1,
            to: Date.now
        ) ?? Date.now
        return start...end
    }()
    let onDone: (Date) -> ()
    let onCancel: () -> ()
    var body: some View {
        VStack{
            HStack{
                Button {
                    onCancel()
                } label: {
                    Text("CANCEL".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .forthRed
                        )
                }
                Spacer()
                Button {
                    onDone(date)
                } label: {
                    Text("Done".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .forthRed
                        )
                }
            }
            Spacer()
            DatePicker(
                "",
                selection: $date,
                in: dateRange,
                displayedComponents: [.date]
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .scaleEffect(1.r)
            
            Spacer()
        }
        .padding(
            EdgeInsets(
                top: 25,
                leading: 25,
                bottom: 0,
                trailing: 25)
        )
        .background(Color.white)
    }
}
