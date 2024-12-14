//
//  attendee.list.cell.view.swift
//  MrArthur
//
//  Created by IPS-169 on 06/09/22.
//

import Foundation
import SwiftUI
// MARK: Cell Design
struct AttendeeListCellView: View {
    var title: String
    var iconAvtar: String
    var isSystemImage : Bool  = false
    let action: ()->()
    var body: some View {
        
        Button(action: action) {
            HStack(spacing: 0) {
                Group {
                    if isSystemImage {
                        Circle()
                           .strokeBorder(Color.primaryBlue,lineWidth: 2.r)
                            .frame(
                                width: 69.34.r,
                                height: 69.34.r
                            )
                            .overlay(
                                Image(systemName: "plus")
                                    .font(.system(
                                        size: 25.r,
                                        weight: .bold,
                                        design: .rounded
                                    ))
                                    .foregroundColor(.primaryBlue)
                            )
                    } else {
                        Image(iconAvtar)
                            .resizable()
                            .frame(
                                width: 69.34.r,
                                height: 69.34.r
                            )
                    }
                }
                
                Text(title)
                    .fontModifier(
                        font: isSystemImage ? .montserratRegular : .montserratBold,
                        size: iPhoneFont18,
                        color: .primaryBlue
                    )
                    .padding(.leading, 15.w)
                
                Spacer()
            }
            .padding(.horizontal, 18.w)
            .padding(.vertical, 20.33.h)
            .background(Color.whiteColor)
            .cornerRadius(30.r)
        }
        .containerShape(Rectangle())
        .buttonStyle(.plain)
    }
}
