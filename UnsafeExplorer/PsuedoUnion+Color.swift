//
//  Color+UInt32.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/2/23.
//

import Foundation
import SwiftUI
import UWCSampler


//        #if canImport(UIKit)
//        typealias NativeColor = UIColor
//        #elseif canImport(AppKit)
//        typealias NativeColor = NSColor
//        #endif

extension PseudoUnion {
    
    public var swiftUIColor:Color {
        Color(red: d_red, green: d_green, blue: d_blue, opacity: d_alpha)
    }
    
    //Lossy! -> Not recommended.
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

