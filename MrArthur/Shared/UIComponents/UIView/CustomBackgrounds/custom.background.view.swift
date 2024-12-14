//
//  custom.background.view.swift
//  MrArthur
//
//  Created by BAPS on 09/11/22.
//

import SwiftUI

struct LinearGradientBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.secondaryRed,
                Color.lightPink
            ],
            startPoint: .top,
            endPoint: .center
        )
    }
}
