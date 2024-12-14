//
//  observerFAQ.observed.swift
//  MrArthur
//
//  Created by Nirav Patel on 11/11/22.
//

import Foundation

extension observerFAQ {
    class Observed:ObservableObject{
       @Published var webViewModelFAQ: CommonWebViewModel = CommonWebViewModel(url: "https://www.apple.com/")
    }
}
