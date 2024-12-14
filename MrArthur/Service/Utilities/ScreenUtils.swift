//
//  ScreenUtils.swift
//  MrArthur
//
//  Created by BAPS on 01/11/22.
//

import Foundation
import SwiftUI

//xdW - 428px
//xdH - 926px

private let deviceWidth: CGFloat = UIScreen.main.bounds.size.width
private let deviceHeight: CGFloat = UIScreen.main.bounds.size.height

private let designWidth: CGFloat = CGFloat(428)
private let designHeight: CGFloat = CGFloat(926)

private var scaleWidth: CGFloat {
    let value = deviceWidth / designWidth
    return value
}

private var scaleHeight: CGFloat {
    let value = deviceHeight / designHeight
    return value
}

private var minScale: CGFloat {
    return (scaleWidth > scaleHeight) ? scaleHeight : scaleWidth
}

class ScreenUtils {
    static func heightByScreenPercent(_ percent: Int) -> CGFloat {
        let _percent = CGFloat(percent) / 100
        let value: CGFloat = deviceHeight * _percent
        return value
    }
    
    static func widthByScreenPercent(_ percent: Int) -> CGFloat {
        let _percent = CGFloat(percent) / 100
        let value: CGFloat = deviceWidth * _percent
        return value
    }
}

extension CGFloat {
    var sp: CGFloat {
        let value = self * minScale
        return value
    }
    
    var w: CGFloat {
        let value = self * scaleWidth
        return value
    }
    
    var h: CGFloat {
        let value = self * scaleHeight
        return value
    }
    
    var r: CGFloat {
        let value = self * minScale
        return value
    }
}

extension Int {
    var sp: CGFloat {
        let _self = CGFloat(self)
        let value = _self * minScale
        return value
    }
    
    var w: CGFloat {
        let _self = CGFloat(self)
        let value = _self * scaleWidth
        return value
    }
    
    var h: CGFloat {
        let _self = CGFloat(self)
        let value = _self * scaleHeight
        return value
    }
    
    var r: CGFloat {
        let _self = CGFloat(self)
        let value = _self * minScale
        return value
    }
}

extension Double {
    var sp: CGFloat {
        let _self = CGFloat(self)
        let value = _self * minScale
        return value
    }
    
    var w: CGFloat {
        let _self = CGFloat(self)
        let value = _self * scaleWidth
        return value
    }
    
    var h: CGFloat {
        let _self = CGFloat(self)
        let value = _self * scaleHeight
        return value
    }
    
    var r: CGFloat {
        let _self = CGFloat(self)
        let value = _self * minScale
        return value
    }
}
