//
//  LoaderObserver.swift
//  MrArthur
//
//  Created by Troo on 21/07/22.
//

import SwiftUI

class LoaderObserver: ObservableObject {
    @Published var showLoader: Bool
    init(showLoader: Bool = false) {
        self.showLoader = showLoader
    }
}
