//
//  app.list.tag.view.swift
//  MrArthur
//
//  Created by BAPS on 17/01/23.
//

import SwiftUI

struct AppListTagView: View {
    let category: AppCategory
    let onSelect: () -> ()
    var body: some View {
        Button(action: onSelect) {
            Text(category.catName)
                .fontModifier(
                    font: .montserratBold,
                    size: 16.sp,
                    color: .primaryBlue
                )
                .padding(.vertical, 5.h)
                .padding(.horizontal, 12.w)
                .overlay {
                    RoundedRectangle(cornerRadius: 16.r)
                    .stroke(
                        Color.primaryBlue,
                        lineWidth: 2.h
                    )
                }
                .background(
                    Group {
                        if category.isSelected {
                            Color.lightPink
                        } else {
                            Color.secondaryRed
                        }
                    }
                        .cornerRadius(16.r)
                )
        }
        .contentShape(Rectangle())
        
    }
}

