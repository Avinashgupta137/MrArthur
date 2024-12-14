//
//  app.list.cell.view.swift
//  MrArthur
//
//  Created by BAPS on 17/01/23.
//

import SwiftUI

struct AppListCellView: View {
    @State var image = UIImage(named: "ic_app_placeholder")!
    let app: RecommandedAppListResponseModel
    let onInstall: () -> ()
    let onShare: () -> ()
    var body: some View {
        HStack(spacing: 0) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 60.r, height: 60.r)
                .cornerRadius(20.r)
                .padding(.trailing, 30.w)
            
            VStack(alignment: .leading, spacing: 5.h){
                if app.catList.count > 0 {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 8.w) {
                            ForEach(app.catList) { category in
                                Text(category.catName)
                                    .fontModifier(
                                        font: .montserratBold,
                                        size: 10.sp,
                                        color: .primaryBlue
                                    )
                                    .padding(.vertical, 3.h)
                                    .padding(.horizontal, 6.w)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16.r)
                                        .stroke(
                                            Color.primaryBlue,
                                            lineWidth: 1.h
                                        )
                                    }
                            }
                        }
                        .padding(1.r)
                    }
                }
                Text(app.appName)
                    .fontModifier(
                        font: .montserratBlack,
                        size: 17.sp,
                        color: .primaryBlue
                    )
                Text(app.appComment)
                    .fontModifier(
                        font: .montserratRegular,
                        size: 11.sp,
                        color: .primaryBlue
                    )
            }
            
            Spacer(minLength: 38.w)
            
            VStack(spacing: 18.h){
                Button(action: onInstall) {
                    Image("ic_plus_rounded_circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30.r, height: 30.r)
                }
                
                Button(action: onShare) {
                    Image("ic_share_circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30.r, height: 30.r)
                }
            }
        }
        .padding(.bottom, 19.h)
        .border(width: 1.r, edges: [.bottom], color: .white)
        .padding(.leading, 21.w)
        .padding(.trailing, 27.w)
        .padding(.top, 19.h)
        .onAppear {
            UtilityMethod().appIconGet(app.appLink) { image in
                if let image = image {
                    self.image = image
                }
            }
        }
    }
}

