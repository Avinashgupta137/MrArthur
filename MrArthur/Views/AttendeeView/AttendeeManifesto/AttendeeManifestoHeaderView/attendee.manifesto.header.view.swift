//
//  AttendeeManifestoHeaderView.swift
//  MrArthur
//
//  Created by IPS-157 on 02/08/22.
//

import SwiftUI

struct AttendeeManifestoHeaderView: View {
    @Binding var questionstate:StateOfQuestion
    @State var showHeader = true

    
    // MARK: - PROPERTIES
    var body: some View {
        AttendeeHeaderProgressBar()
            .frame(height: 6)
            .opacity(showHeader ? 1 : 0)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
            .background(Color.clear)
            .onChange(of: questionstate) { newValue in
                switch questionstate {
                case .answerPending, .none:
                    showHeader = true
                case .answerGiving, .answerGiven:
                    showHeader = false
                }
            }
    }
}

