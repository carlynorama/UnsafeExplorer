//
//  Color+UInt8.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/2/23.
//

import Foundation
import SwiftUI


#if canImport(UIKit)
typealias NativeColor = UIColor
#elseif canImport(AppKit)
typealias NativeColor = NSColor
#endif

extension NativeColor {
    convenience init(red:UInt8, green:UInt8, blue:UInt8, alpha:UInt8) {
        func d(_ i:UInt8) -> Double {
            Double(i)/255.0
        }
        self.init(red: d(red), green: d(green), blue: d(blue), alpha: d(alpha))
    }
}

extension Color {
    #if canImport(UIKit)
    //typealias NativeColor = UIColor
    init(nativeColor:NativeColor) {
        self.init(uiColor: nativeColor)
    }
    #elseif canImport(AppKit)
    //typealias NativeColor = NSColor
    init(nativeColor:NativeColor) {
        self.init(nsColor:nativeColor)
    }
    #endif
}

//https://stackoverflow.com/questions/56586055/how-to-get-rgb-components-from-color-in-swiftui
extension Color {
    #if canImport(UIKit)
    var asNative: UIColor { UIColor(self) }
    #elseif canImport(AppKit)
    var asNative: NSColor { NSColor(self) }
    #endif

    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = asNative.usingColorSpace(.deviceRGB)!
        var t = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        color.getRed(&t.0, green: &t.1, blue: &t.2, alpha: &t.3)
        return t
    }

    var hsva: (hue: CGFloat, saturation: CGFloat, value: CGFloat, alpha: CGFloat) {
        let color = asNative.usingColorSpace(.deviceRGB)!
        var t = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        color.getHue(&t.0, saturation: &t.1, brightness: &t.2, alpha: &t.3)
        return t
    }
}
