//
//  web.view.model.swift
//  MrArthur
//
//  Created by Troo on 07/09/22.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    var showLoader = PassthroughSubject<Bool, Never>()
    var onBackPublisher = PassthroughSubject<Void, Never>()
}
