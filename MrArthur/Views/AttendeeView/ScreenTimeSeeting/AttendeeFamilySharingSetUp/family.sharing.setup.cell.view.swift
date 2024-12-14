//
//  family.sharing.setup.cell.view.swift
//  MrArthur
//
//  Created by BAPS on 14/11/22.
//

import SwiftUI

struct FamilySharingSetupCellView<Content: View>: View {
    let icon: String?
    let content: Content
    
    init(
        icon: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        HStack(spacing: 27.w){
            Group {
                if let icon = self.icon {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("")
                }
            }
            .frame(
                width: 59.r,
                height: 59.r
            )
            
            self.content
        }
    }
}
