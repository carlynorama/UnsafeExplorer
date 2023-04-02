//
//  OpaquePointerView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/1/23.
//

import SwiftUI

import UWCSampler


final class ColorModel:ObservableObject {
    private var c_colorBridge:ColorBridge
    
    //NativeColor typeAlias defined in extension.
    init(color:NativeColor) {
        self.c_colorBridge = ColorBridge()
        self.color = color
    }
    
    var color:NativeColor {
        get {
            NativeColor(red: c_colorBridge.red, green: c_colorBridge.green, blue: c_colorBridge.blue, alpha: c_colorBridge.alpha)
        }
        set {
            print(newValue)
            print(newValue.cgColor)
            if let c = newValue.cgColor.components {
                c_colorBridge.setColor(red:UInt8(c[0]*255), green: UInt8(c[1]*255), blue: UInt8(c[2]*255), alpha: UInt8(c[3]*255))
                objectWillChange.send()
            } else {
                print("No change")
            }

            
            
        }
    }
}

struct OpaquePointersView: View {
    //Cannot Use. Built in colors don't have CGColors!!
    private let colors:[Color] = [.cyan, .pink, .yellow, .black, .accentColor, .indigo, .mint, .purple, .teal, .brown, .white]
    @State var structColor = BridgeColor(red:77, green: 123, blue: 11, alpha: 255)
    @StateObject var classColor = ColorModel(color: .orange)
    var body: some View {
        VStack {
            Text("OpaquePointersView")
            ZStack {
                //in extension BridgeColor+Color and Color+UInt8+NativeColor
                structColor.swiftUIColor
                Text("Struct")
            }
            
            Button("Run Struct Test Functions") {
                bridgeColorTests()
            }
            
            ZStack {
                //in extension BridgeColor+Color and Color+UInt8
                Color(nativeColor: classColor.color)
                Text("Class")
            }
            
            

            
            Button("Update Class Color") {
                updateClassColor()
            }
            Text("Function does not check that newColor != oldColor. There are only ~10 colors so color may not always change.").font(.caption)
        }
    }
    
    func updateClassColor() {
        //.asNative in extension Color+UInt8+NativeColor
        classColor.color = colors[Int.random(in: 0..<colors.count)].asNative
    }
    
    
    func bridgeColorTests() {
        let bridgeColor:BridgeColor = BridgeColor(red:77, green: 123, blue: 11, alpha: 255)
        
        let val_pt = bridgeColor.asUINT32FromPointerType()
        let val_ctp = bridgeColor.asUINT32FromPointerToConcreteType()
        
        print("expeced hex value of ints \(bridgeColor.printExpectedInt())")
        print("hex from pointer typedef = \(String(format:"0x%08x",val_pt))")
        print("hex from pointer to concrete typedef = \(String(format:"0x%08x",val_ctp))")
        
    }
    
}
struct OpaquePointersView_Previews: PreviewProvider {
    static var previews: some View {
        OpaquePointersView()
    }
}
