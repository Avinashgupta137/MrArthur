//
//  att.appcategory.picker.view.swift
//  MrArthur
//
//  Created by BAPS on 16/11/22.
//

import SwiftUI

struct ATTAppcategoryPickerView<Content: View>: View {
    let onCancel: () -> ()
    let onDone: () -> ()
    let content: Content
    
    init(
        onCancel: @escaping () -> (),
        onDone: @escaping () -> (),
        @ViewBuilder content: () -> Content
    ) {
        self.onDone = onDone
        self.onCancel = onCancel
        self.content = content()
    }
    var body: some View {
        VStack {
            HStack{
                Button {
                    onCancel()
                } label: {
                    Text("CANCEL".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .forthRed
                        )
                }
                Spacer()
                Button {
                    onDone()
                } label: {
                    Text("Done".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont18,
                            color: .forthRed
                        )
                }
            }
            .padding(.vertical, 12.h)
            .padding(.horizontal, 16.h)
            content
            Spacer()
        }
    }
}

struct AppDeatilsView : View{
    let image : String
    let titleImage : String
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 40.r, height: 40.r)
                .background(Color.white.cornerRadius(28.r))
            Text(titleImage.localized)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont25,
                    color: .primaryBlue
                )
                .padding(.horizontal, 10.r)
                .padding(.vertical, 5.r)
                .background(Color.white.cornerRadius(28.r))
        }
    }
}

struct BrowserDetails : View{
    let image : String
    let titleImage : String
    var body: some View {
        HStack(spacing: 0){
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 38.r, height: 38.r)
            Text(titleImage)
                .fontModifier(
                    font: .montserratBlack,
                    size: iPhoneFont18,
                    color: .primaryBlue
                )
                .padding(.leading, 2.w)
                .padding(.trailing, 6.w)
                .padding(.vertical, 5.w)
        }
        .background(Color.white.cornerRadius(28.r))
    }
}
struct BrowserDetails_Previews: PreviewProvider {
    static var previews: some View {
        BrowserDetails(
            image: "IOS_ICONS_CHROME",
            titleImage: "Chrome"
        )
        .multiPreview
    }
}
