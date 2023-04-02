//
//  Color+UInt32.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/2/23.
//

import Foundation
import SwiftUI
import UWCSampler


extension PseudoUnion {
    
    public var swiftUIColor:Color {
        Color(red: d_red, green: d_green, blue: d_blue, opacity: d_alpha)
    }
    
    //Lossy.
    init?(swiftUIColor:Color) {
        //[CGFloat]? of [red, green, blue, alpha].
        if let c = swiftUIColor.cgColor?.components {
            //self.init(red:UInt8(c[0]*255), green: UInt8(c[1]*255), blue: UInt8(c[2]*255), alpha: UInt8(c[3]*255))
            self.init(bytes: c.reversed().map { UInt8($0*255) })
        } else {
            return nil
        }
    }
}

//
//extension Color {
//    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
//
//        #if canImport(UIKit)
//        typealias NativeColor = UIColor
//        #elseif canImport(AppKit)
//        typealias NativeColor = NSColor
//        #endif
//
//        var r: CGFloat = 0
//        var g: CGFloat = 0
//        var b: CGFloat = 0
//        var o: CGFloat = 0
//
////        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
////            // You can handle the failure here as you want
////            return (0, 0, 0, 0)
////        }
//
//        NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o)
//
//        return (r, g, b, o)
//    }
//}
