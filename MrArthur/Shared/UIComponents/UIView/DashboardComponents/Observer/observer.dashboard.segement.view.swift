//
//  observer.dashboard.segement.view.swift
//  MrArthur
//
//  Created by Troo on 29/08/22.
//

import SwiftUI

enum EDuration: Int {
    case TODAY
    case WEEK
    case MONTH
}


struct ObserverDashboardSegementView: View {
    @Binding var selected: EDuration
    var body: some View {
        HStack(spacing: 0) {
            Button {
                selected = .TODAY
            } label: {
                Text("today".localized)
                    .fontModifier(
                        font: selected == .TODAY
                        ? .montserratBold
                        : .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .frame(minWidth: 0, maxWidth: UIScreen.screenWidth)
                    .frame(height: 31.h)
                    .background(
                        Group {
                            switch selected {
                            case .TODAY:
                                Color.white.cornerRadius(16.r)
                            default:
                                Color.clear
                            }
                        }
                    )
            }
            .contentShape(Rectangle())
            
            Button {
                selected = .WEEK
            } label: {
                Text("7 days".localized)
                    .fontModifier(
                        font: selected == .WEEK
                        ? .montserratBold
                        : .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .frame(minWidth: 0, maxWidth: UIScreen.screenWidth)
                    .frame(height: 31.h)
                    .background(
                        Group {
                            switch selected {
                            case .WEEK:
                                Color.white.cornerRadius(16.r)
                            default:
                                Color.clear
                            }
                        }
                    )
            }
            .contentShape(Rectangle())
            
            Button {
                selected = .MONTH
            } label: {
                Text("30 days".localized)
                    .fontModifier(
                        font: selected == .MONTH
                        ? .montserratBold
                        : .montserratRegular,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .frame(minWidth: 0, maxWidth: UIScreen.screenWidth)
                    .frame(height: 31.h)
                    .background(
                        Group {
                            switch selected {
                            case .MONTH:
                                Color.white.cornerRadius(16.r)
                            default:
                                Color.clear
                            }
                        }
                    )
            }
            .contentShape(Rectangle())
           
        }
        .frame(height: 31.h)
        .overlay(
            RoundedRectangle(
                cornerRadius: 16.r
            ).stroke(
                Color.white
            )
        )
    }
}

struct ObserverDashboardSegementViewview_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ObserverDashboardSegementView(selected: .constant(.MONTH))
                .padding(.horizontal, 60)
            Spacer()
        }
        .background(Color.lightPink)
    }
}
