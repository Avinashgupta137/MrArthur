//
//  ShareViewExt.swift
//  MrArthur
//
//  Created by BAPS on 18/11/22.
//

import Foundation
import SwiftUI

struct RectGetter: View {
    @Binding var rect: CGRect
    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }
    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
