//
//  observer.manifesto.header.view.swift
//  MrArthur
//
//  Created by IPS-169 on 08/07/22.
//

import SwiftUI
import Foundation
import UIKit
struct ObserverHeaderView: View {
    
    var body: some View {
        ObserverHeaderProgressBar()
            .frame(height: 7.h)
            .padding(.horizontal, 20.w)
            .padding(.bottom, 20.w)
            .background(Color.clear)
    }
}


