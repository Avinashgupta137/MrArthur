//
//  onbaord.indicator.view.swift
//  MrArthur
//
//  Created by BAPS on 19/01/23.
//

import SwiftUI

struct OnbaordIndicatorView: View {
    let isFill: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 10.r)
            .fill(isFill ? Color.primaryBlue : .clear)
            .frame(
                width: isFill ? 30.r : 10.r,
                height: 10.r
            )
            .overlay {
                RoundedRectangle(cornerRadius: 10.r)
                    .stroke(isFill ? .clear : Color.primaryBlue)
            }
    }
}
