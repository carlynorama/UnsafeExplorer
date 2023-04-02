//
//  Color+Uint32.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/2/23.
//

import Foundation
import SwiftUI



fileprivate extension UInt32 {
    var b0:UInt8 {
        return UInt8(self & 0xFF)
    }
    
    var b1:UInt8 {
        return UInt8((self >> 8) & 0xFF)
    }
    
    var b2:UInt8 {
        return UInt8((self >> 16) & 0xFF)
    }
    
    var b3:UInt8 {
        return UInt8((self >> 24) & 0xFF)
    }
}

fileprivate extension UInt8 {
    var zeroToOne:Double {
        Double(self)/255.0
    }
}

extension Color {
    //Where r = byte[3] and a = byte[0]
    init(uint32_ABGR:UInt32) {
        self.init(red: uint32_ABGR.b3.zeroToOne,
                  green: uint32_ABGR.b2.zeroToOne,
                  blue: uint32_ABGR.b1.zeroToOne,
                  opacity: uint32_ABGR.b0.zeroToOne)
    }
    

}
