//
//  ViewModifiers.swift
//  MrArthur
//
//  Created by Troo on 21/07/22.
//

import SwiftUI


struct HideNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct FullSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
    }
}

struct StatusBarStyleModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            color
                .frame(width: UIScreen.screenWidth, height: statusBarHeight)
            
            content
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct NavigationStatusBarStyleModifier: ViewModifier {
    let title: String
    let color: Color
    
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Status bar
            color
                .frame(width: UIScreen.screenWidth, height: statusBarHeight)
            //Navigation bar
            HStack{
                Spacer()
                Text(title.localized)
                    .fontModifier(font: .montserratBold, size: 20, color: Color.primaryBlue)
                Spacer()
            }
            .padding(.vertical, 15)
            .background(color)
            //view
            content
        }
        .hideNavigation
        .edgesIgnoringSafeArea(.all)
    }
}

struct NavigationBarWithBackButtonModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: String
    let color: Color
    let showBackButton: Bool
    
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            ZStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Text(title.localized)
                        .fontModifier(font: .montserratBold, size: 20, color: Color.primaryBlue)
                    Spacer()
                }
                .zIndex(0)
                .padding(.vertical, 15)
                
                Button {
                    if showBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.secondaryBlue)
                        .frame(width: 25, height: 25, alignment: .leading)
                }
                .padding(.leading, 16.resizable)
                .opacity(showBackButton ? 0 : 1)
                .disabled(!showBackButton)
                
            }
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .statusBarColor)
        .edgesIgnoringSafeArea(.top)
    }
}

struct NavigationBarWithBackButtonActionModifier: ViewModifier {
    
    let title: String
    let color: Color
    
    let action: () -> ()
    
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            ZStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Text(title.localized)
                        .fontModifier(font: .montserratBold, size: 20, color: Color.primaryBlue)
                    Spacer()
                }
                .zIndex(0)
                .padding(.vertical, 15)
                
                Button {
                    action()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.secondaryBlue)
                        .frame(width: 25, height: 25, alignment: .leading)
                }
                .padding(.leading, 16.resizable)
                
            }
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .statusBarColor)
        .edgesIgnoringSafeArea(.top)
    }
}
struct NavigationBarWithBackButtonWidgitModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: String
    let color: Color
    let showBackButton: Bool
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            ZStack(alignment: .leading) {
                HStack{
                    Spacer(minLength: 100)
                    Text(title.localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: 20,
                            color: Color.primaryBlue
                        )
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 16)
                }
                .zIndex(0)
                .padding(.vertical, 15)
                
                Button {
                    if showBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    HStack(spacing: CGFloat.dynamicValue(foriPhone: 5, foriPad: 10)){
                        Image(systemName: "chevron.backward")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20, alignment: .leading)
                            .foregroundColor(.forthRed)
                            .scaleEffect(CGFloat.dynamicValue(foriPhone: 1, foriPad: 1.5))
                        
                        Text("Back".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryRed
                            )
                    }
                }
                .padding(.leading, 16.resizable)
                .padding(.vertical, 15)
                .opacity(showBackButton ? 1 : 0)
                .disabled(!showBackButton)
            }
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .statusBarColor)
        .hideNavigation
        .edgesIgnoringSafeArea(.all)
    }
}
struct NavigationBarWithBackCancelButtonWidgitModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: String
    let color: Color
    let showBackButton: Bool
    let lastButtontitle: String
    let action: () -> ()
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            HStack(spacing: 0) {
//                if showBackButton {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack(spacing: CGFloat.dynamicValue(foriPhone: 5, foriPad: 10)){
                            Image(systemName: "chevron.backward")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20, alignment: .leading)
                                .foregroundColor(.forthRed)
                                .scaleEffect(CGFloat.dynamicValue(foriPhone: 1, foriPad: 1.5))
                            
                            Text("Back".localized)
                                .fontModifier(
                                    font: .montserratRegular,
                                    size: iPhoneFont18,
                                    color: .primaryRed
                                )
                        }
                    }
                    .padding(.leading, 16.w)
                    .padding(.vertical, 15)
                    .opacity(showBackButton ? 1 : 0)
                    .disabled(!showBackButton)
//                }
                
                Spacer(minLength: 16.w)
                
                Text(title.localized)
                    .fontModifier(
                        font: .montserratBold,
                        size: 20,
                        color: Color.primaryBlue
                    )
                    .lineLimit(1)
                
                Spacer(minLength: 16.w)
                
                Button {
                    action()
                } label: {
                    Text(lastButtontitle.localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .primaryRed
                        )
                }
                .padding(.trailing, 16.w)
                .padding(.vertical, 15)
            }
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .statusBarColor)
        .hideNavigation
        .edgesIgnoringSafeArea(.top)
    }
}




struct NavigationBarWithBackButtonAmplitudeEventModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: String
    let color: Color
    let amplitudeEvent: EAmplitudeEventKey
    let showBackButton: Bool
    let lastButtontitle: String
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            ZStack(alignment: .leading) {
                HStack{
                    Spacer(minLength: 85)
                    Text(title.localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: 20,
                            color: Color.primaryBlue
                        )
                        .lineLimit(1)
                    Spacer()
                }
                .zIndex(0)
                .padding(.vertical, 15)
                
                Button {
                    AmplitudeService.sendEvent(key: amplitudeEvent)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack(spacing: CGFloat.dynamicValue(foriPhone: 5, foriPad: 10)){
                        Image(systemName: "chevron.backward")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20, alignment: .leading)
                            .foregroundColor(.forthRed)
                            .scaleEffect(CGFloat.dynamicValue(foriPhone: 1, foriPad: 1.5))
                        
                        Text(lastButtontitle.localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont18,
                                color: .primaryRed
                            )
                    }
                }
                .padding(.leading, 16.resizable)
                .padding(.vertical, 15)
                .opacity(showBackButton ? 1 : 0)
                .disabled(!showBackButton)
                
            }
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .statusBarColor)
        .hideNavigation
        .edgesIgnoringSafeArea(.top)
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct PreviewProviderView: ViewModifier {
    let previewFor: EPreviewDevices
    func body(content: Content) -> some View {
        content
            .previewDevice(PreviewDevice(rawValue: previewFor.rawValue))
            .previewDisplayName(previewFor.rawValue)
    }
}

private struct MultiPreviewProvider: ViewModifier {
    func body(content: Content) -> some View {
        
        content
            .multiPreview(.iPhone_14_Pro)
        
        content
            .multiPreview(.iPhone_14)
        
        content
            .multiPreview(.iPhone_8)
        
        content
            .multiPreview(.iPad_Pro_12_9_inch_5th_generation)
    }
}

extension Image {
    func imageModifier(
        iPhoneSize: CGSize,
        iPadSize: CGSize,
        alignment: Alignment = .center
    ) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(
                width: .dynamicValue(foriPhone: iPhoneSize.width, foriPad: iPadSize.width),
                height: .dynamicValue(foriPhone: iPhoneSize.height, foriPad: iPadSize.height),
                alignment: alignment
            )
    }
}

extension View {
    
    @ViewBuilder func scrollEnabled(_ enabled: Bool) -> some View {
        if enabled {
            self
        } else {
            simultaneousGesture(DragGesture(minimumDistance: 0),
                                including: .all)
        }
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    
    var multiPreview: some View {
        modifier(MultiPreviewProvider())
    }
    
    func multiPreview(_ previewFor: EPreviewDevices) -> some View {
        self.modifier(PreviewProviderView(previewFor: previewFor))
    }
    
    func viewSizeModifier(
        iPhoneSize: CGSize,
        iPadSize: CGSize,
        alignment: Alignment = .center
    ) -> some View {
        self
            .frame(
                width: .dynamicValue(foriPhone: iPhoneSize.width, foriPad: iPadSize.width),
                height: .dynamicValue(foriPhone: iPhoneSize.height, foriPad: iPadSize.height),
                alignment: alignment
            )
    }
    
    var hideNavigation: some View {
        modifier(HideNavigationBarModifier())
    }
    
    var fullScreenFrame: some View {
        modifier(FullSizeModifier())
    }
    
    func statusBarStyle(color: Color) -> some View {
        self.modifier(StatusBarStyleModifier(color: color))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func customNavigationView(title: String, color: Color) -> some View {
        self.modifier(NavigationStatusBarStyleModifier(title: title.localized, color: color))
    }
    
    func customNavigationViewWithBack(title: String, color: Color, showBackButton: Bool = true) -> some View {
        self.modifier(NavigationBarWithBackButtonModifier(
            title: title.localized,
            color: color,
            showBackButton: showBackButton
        ))
    }
    
    func customNavigationViewWithBackAction(title: String, color: Color, action: @escaping () -> ()) -> some View {
        self.modifier(NavigationBarWithBackButtonActionModifier(title: title, color: color, action: action))
    }
    
    func customNavigationViewWithBackWidgit(
        title: String,
        color: Color,
        backTitle: String = "Back".localized,
        showBackButton: Bool = true
    ) -> some View {
        self.modifier(
            NavigationBarWithBackButtonWidgitModifier(
                title: title,
                color: color,
                showBackButton: showBackButton
            )
        )
    }
    
    func customNavigationViewWithBackCancelWidgit(
        title: String,
        color: Color,
        showBackButton: Bool = true,
        lastButtontitle : String,
        amplitudeEvent: EAmplitudeEventKey,
        action: @escaping () -> ()
    ) -> some View {
        self.modifier(
            NavigationBarWithBackCancelButtonWidgitModifier(
                title: title,
                color: color,
                showBackButton: showBackButton,
                lastButtontitle: lastButtontitle,
                action: action
            ))
    }
    func customNavigationViewWithBackWithAmplitudeEvent(
        title: String,
        color: Color,
        amplitudeEvent: EAmplitudeEventKey,
        backTitle: String = "Back".localized
    ) -> some View {
        self.modifier(
            NavigationBarWithBackButtonAmplitudeEventModifier(
                title: title,
                color: color,
                amplitudeEvent: amplitudeEvent,
                showBackButton: true,
                lastButtontitle: backTitle
            )
        )
    }
    
    
    func customNavigationViewWithoutBackWithAmplitudeEvent(
        title: String,
        color: Color,
        backTitle: String = "Back".localized,
        amplitudeEvent: EAmplitudeEventKey,
        showBackButton: Bool = true
    ) -> some View {
        self.modifier(
            NavigationBarWithBackButtonAmplitudeEventModifier(
                title: title,
                color: color,
                amplitudeEvent: amplitudeEvent,
                showBackButton:showBackButton,
                lastButtontitle: backTitle
            )
        )
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
            if condition {
                transform(self)
            } else {
                self
            }
        }
}
