//
//  GenderRadioButtonGroupView.swift
//  MrArthur
//
//  Created by Troo on 19/07/22.
//

import SwiftUI

struct GenderRadioButtonGroupView: View {
    
    let fontSize: CGFloat = 18
    @State var girlSelected: Bool = false
    @State var boySelected: Bool = false
    let onChange: (Int) -> ()
    var body: some View {
        HStack(spacing: 31.w){
            RadioButtonView(title: "GIRL".localized, fontSize: fontSize, selected: $girlSelected, onSelect: {
                girlSelected = true
                boySelected = false
                onChange(1)
            })
            .foregroundColor(.whiteColor)
            RadioButtonView(title: "BOY".localized, fontSize: fontSize, selected: $boySelected, onSelect: {
                girlSelected = false
                boySelected = true
                onChange(2)
            })
        }
    }
}
