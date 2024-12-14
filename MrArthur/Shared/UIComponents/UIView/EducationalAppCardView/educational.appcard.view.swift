//
//  educational.appcard.view.swift
//  MrArthur
//
//  Created by IPS-157 on 01/09/22.
//

import SwiftUI

struct EducationalAppCardView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isAppSelected = false
    @State var appIconImage: Data? = UIImage(systemName: "eraser.fill")?.pngData()
    @State var image = UIImage(named: "ic_app_placeholder")!
    let app: RecommandedAppListResponseModel
    let appInstalledInDevice : Bool
    let onInstall: () -> ()
    let onShare: () -> ()
    let onSeeOnAppStore: () -> ()
    
    var seprator: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(height: 1.iPadIncBy(0.5))
    }
    
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 61.r, height: 61.r)
                        .cornerRadius(10.r)
                        .padding(.trailing, 20.w)
                        .onChange(of: appIconImage) { data in
                            guard let data = data else { return }
                            self.image = UIImage(data: data) ?? UIImage.init(systemName: "square.and.pencil.circle.fill")!
                        }
                    VStack(alignment: .leading, spacing: 12.h){
                        Text(app.appName)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                            .multilineTextAlignment(.leading)
                        
                        Text("4 + Year")
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont20,
                                color: .primaryBlue
                            )
                    }
                    
                    Spacer(minLength: 16.w)
                    
                    Button {
                        withAnimation {
                            isAppSelected.toggle()
                        }
                    } label: {
                        Image(isAppSelected ? "SettingsBulletCarrot2" :"SettingsBulletCarrot1")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 40.r,
                                height: 40.r
                            )
                    }
                    .contentShape(Rectangle())
                }
                if isAppSelected {
                    Text(app.appComment)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont15,
                            color: .primaryBlue
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20.h)
                }
            }
            .padding(16.h)
            .background(Color.white.cornerRadius(28.r))
            .overlay(
                RoundedRectangle(cornerRadius: 28.r)
                    .stroke(appInstalledInDevice ? Color.green : Color.white , lineWidth: 3.w)
            )
            
            if isAppSelected {
                HStack(spacing: 0) {
                    Spacer(minLength: 24.w)
                    VStack(alignment: .trailing, spacing: 0){
                        Button(action: onInstall) {
                            HStack{
                                Text("Install App".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont18,
                                        color: .blue
                                    )
                                Spacer()
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 12.h)
                        .padding(.horizontal, 16.w)
                        .border(width: 0.5.r, edges: [.bottom], color: .primaryBlue)
                        Button(action: onShare) {
                            HStack{
                                Text("Share".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont18,
                                        color: .blue
                                    )
                                Spacer()
                                Image(systemName: "arrowshape.turn.up.right")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 12.h)
                        .padding(.horizontal, 16.w)
                        .border(width: 0.5.r, edges: [.bottom], color: .primaryBlue)
                        
                        Button(action: onSeeOnAppStore) {
                            HStack{
                                Text("See on the App store".localized)
                                    .fontModifier(
                                        font: .montserratRegular,
                                        size: iPhoneFont18,
                                        color: .blue
                                    )
                                Spacer()
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 12.h)
                        .padding(.horizontal, 16.w)
                    }
                    .disabled(!isAppSelected)
                    .frame(width: 281.w)
                    .background(Color.backgroundGrey.cornerRadius(16.r))
                }
                .padding(.top, 10.h)
            }
        }
        .onAppear {
            UtilityMethod().appIconGet(app.appLink) { image in
                if let image = image {
                    self.image = image
                }
            }
        }
    }
}

