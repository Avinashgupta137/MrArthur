//
//  web.main.view.swift
//  MrArthur
//
//  Created by Troo on 07/09/22.
//

import SwiftUI

struct WebMainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var media: MediaDetails
    @Binding var isPresented: Bool
    @ObservedObject var webViewModel = WebViewModel()
    var body: some View {
        WebView(html: media.medialHtmlString, viewModel: webViewModel)
            .onAppear{
                self.rotateScreen(orientation: .landscape)
            }
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
                    .padding(10)
                    .background(Color.progressGray.cornerRadius(20).opacity(0.4))
                    .padding()
                    .onTapGesture {
                        self.webViewModel.onBackPublisher.send()
                        self.rotateScreen(orientation: .portrait)
                        isPresented.toggle()
                    },
                alignment: .topLeading
            )
    }
    
    private func rotateScreen(orientation: UIInterfaceOrientationMask) {
        DispatchQueue.main.async {
            AppDelegate.orientationLock = orientation
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            if let controller = UIApplication.shared.keyWindow?.rootViewController {
                controller.setNeedsUpdateOfSupportedInterfaceOrientations()
                controller.navigationController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientation)) { error in
                    print(error)
                    print(windowScene?.effectiveGeometry ?? "")
                }
            }
        }
    }
}
