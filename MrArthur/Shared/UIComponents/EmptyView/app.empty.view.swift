//
//  AppEmptyView.swift
//  MrArthur
//
//  Created by Troo on 25/08/22.
//

import SwiftUI

struct AppEmptyView: View {
    var note: String = "404"
    var body: some View {
        VStack(spacing: 22){
            Spacer()
            Image("MrArthurIANotHappyAtAllFace")
                .resizable()
                .frame(
                    width: UIScreen.screenWidth * 0.5,
                    height: UIScreen.screenWidth * 0.5
                )
            Text("PAGE NOT FOUND".localized)
                .fontModifier(
                    font: .montserratBoldItalic,
                    size: 22,
                    color: .secondaryBlue
                )
            Text(note)
                .fontModifier(
                    font: .montserratBoldItalic,
                    size: 22,
                    color: .secondaryBlue
                )
            Spacer()
        }
    }
}

struct AppEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        AppEmptyView()
    }
}
