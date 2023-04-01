//
//  OpaquePointerView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/1/23.
//

import SwiftUI
import UWCSampler

struct OpaquePointersView: View {
    var body: some View {
        Text("OpaquePointersView")
    }
    
    func bridgeColorTests() {
        let bridgeColor:BridgeColor = BridgeColor(red:77, green: 123, blue: 11, alpha: 255)
        
        let val_pt = bridgeColor.asUINT32FromPointerType()
        let val_ctp = bridgeColor.asUINT32FromPointerToConcreteType()
        
        bridgeColor.printExpectedInt()
        print("Pointer typedef = \(String(format:"0x%08x",val_pt))")
        print("Pointer to concrete typedef = \(String(format:"0x%08x",val_ctp))")
        
    }
    
}
struct OpaquePointersView_Previews: PreviewProvider {
    static var previews: some View {
        OpaquePointersView()
    }
}
