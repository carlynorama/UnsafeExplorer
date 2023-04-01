//
//  PseudoUnionView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/1/23.
//

import SwiftUI
import UWCSampler

struct PseudoUnionView: View {
    @State var pseu = PseudoUnion(full: 0xFF0000FF)
    var body: some View {
        VStack {
            Color(red: Double(pseu.red)/255.0, green: Double(pseu.green)/255.0, blue: Double(pseu.blue)/255.0, opacity: Double(pseu.alpha)/255.0)
            Text(pseu.bytes.description)
            Text("Red: \(pseu.red)")
            Slider(value: UInt8DoubleBinding($pseu.red).doubleValue, in: 0...255, step: 1)
            Text("Green: \(pseu.green)")
            Slider(value: UInt8DoubleBinding($pseu.green).doubleValue, in: 0...255, step: 1)
            Text("Blue: \(pseu.blue)")
            Slider(value: UInt8DoubleBinding($pseu.blue).doubleValue, in: 0...255, step: 1)
            Text("Alpha: \(pseu.alpha)")
            Slider(value: UInt8DoubleBinding($pseu.alpha).doubleValue, in: 0...255, step: 1)
        }
        
    }
    
    func pseudoUnionFuncs() {
        var test = PseudoUnion(full:0xFFCC9966)
        test.testPrint()
        
        test.red = 0x11
        test.green = 0x44
        test.blue = 0x77
        test.alpha = 0xAA
        
        test.testPrint()
        
        test.bytes[0] = 35
        test.bytes[1] = 127
        test.bytes[2] = 200
        test.bytes[3] = 61
        
        test.testPrint()
    }
}



struct UInt8DoubleBinding {
    let intValue : Binding<UInt8>
    let doubleValue : Binding<Double>
    
    init(_ intValue : Binding<UInt8>) {
        self.intValue = intValue
        
        self.doubleValue = Binding<Double>(get: {
            return Double(intValue.wrappedValue)
        }, set: {
            intValue.wrappedValue = UInt8($0)
        })
    }
}

struct PseudoUnionView_Previews: PreviewProvider {
    static var previews: some View {
        PseudoUnionView()
    }
}
