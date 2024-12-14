//
//  widget.extensions.swift
//  MrArthur
//
//  Created by BAPS on 12/01/23.
//

import Foundation

extension Int {
    var _toTimeFormate: String {
        return String(format: "%02d", self)
    }
}

extension String {
    var _localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
