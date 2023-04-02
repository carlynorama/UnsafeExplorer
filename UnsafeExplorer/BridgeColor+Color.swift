//
//  BridgeColor+Color.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/2/23.
//

import Foundation
import UWCSampler
import SwiftUI


extension BridgeColor {
    //See Color+UInt8+NativeColor
    public var swiftUIColor:Color {
        Color(nativeColor:NativeColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    //Lossy! -> Not recommended.
    init?(swiftUIColor:Color) {
        //[CGFloat]? of [red, green, blue, alpha].
        if let c = swiftUIColor.cgColor?.components {
            self.init(red:UInt8(c[0]*255), green: UInt8(c[1]*255), blue: UInt8(c[2]*255), alpha: UInt8(c[3]*255))
        } else {
            return nil
        }
    }
}
