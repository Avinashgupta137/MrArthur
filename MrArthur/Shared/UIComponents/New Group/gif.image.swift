//
//  GifImage.swift
//  MrArthur
//
//  Created by IPS-157 on 09/08/22.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = Bundle.main.url(forResource: name, withExtension: "gif") {
            if let data = try? Data(contentsOf: url){
                webView.load(
                    data,
                    mimeType: "image/gif",
                    characterEncodingName: "UTF-8",
                    baseURL: url.deletingLastPathComponent()
                )
            }
            webView.scrollView.isScrollEnabled = false
            webView.backgroundColor = .clear
            webView.isOpaque = false
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.backgroundColor = .clear
        uiView.isOpaque = false
        uiView.reload()
    }
    
    
}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("BlueLoader")
    }
}
