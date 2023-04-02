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
    
}
