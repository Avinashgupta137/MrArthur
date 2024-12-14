//
//  widget.component.view.swift
//  MrArthur
//
//  Created by BAPS on 12/01/23.
//

import Foundation
import SwiftUI

struct WidgetRowView : View {
    let icon: String
    let label: String
    let value: String
    var body: some View {
        HStack(spacing: 0){
            Image(icon)
                .resizable()
                .scaledToFill()
                .frame(width: 7.r, height: 7.r)
                .padding(.trailing, 3.w)
            Text(label._localized.uppercased())
                .font(.system(size: 7.sp, weight: .bold, design: .rounded))
            Spacer(minLength: 3.w)
            Text(value)
                .font(.system(size: 8.sp, weight: .bold, design: .rounded))
        }
    }
}
