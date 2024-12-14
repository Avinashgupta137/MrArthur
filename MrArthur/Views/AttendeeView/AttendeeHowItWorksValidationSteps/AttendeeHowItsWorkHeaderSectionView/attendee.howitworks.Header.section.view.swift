//
//  attendee.howitworks.Header.section.view.swift
//  MrArthur
//
//  Created by Amit Sinha on 02/11/22.
//

import SwiftUI

struct AttendeeHowItsWorkHeaderSectionView: View {
    @State var showHeader = true
    var body: some View {
        HowItsWorkProgressBar()
            .frame(
                height: CGFloat.dynamicValue(foriPhone: 6, foriPad: 10)
            )
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 20,
                    bottom: 20,
                    trailing: 20
                )
            )
            .background(Color.clear)
    }
}
