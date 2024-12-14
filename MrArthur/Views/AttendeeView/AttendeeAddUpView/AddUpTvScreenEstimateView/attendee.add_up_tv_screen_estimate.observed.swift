//
//  AddUpTvScreenEstimateView+Observed.swift
//  MrArthur
//
//  Created by Amit Sinha on 25/07/22.
//

import Foundation
import SwiftUI

extension AddUpTvScreenEstimateView{
    class Observed:ObservableObject{
    }
}
class AddUpEstimate: ObservableObject {
    @Published var currentIndex: Int
    init(index: Int = 0) {
        self.currentIndex = index
        print("MANIFESTO   INDEX   : \(index)")
        let token = CurrentUserService.getToken()
        print("CURRENT USER TOKEN :")
        dump(token)
    }
}


