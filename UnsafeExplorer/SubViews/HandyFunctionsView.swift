//
//  HandyFunctionsView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/1/23.
//

import SwiftUI
import UWCSampler

struct HandyFunctionsView: View {
    let handy = MiscHandy()
    var body: some View {
        Button("TupleBridge Tests") {
            tupleBridge()
        }
        
//        Button("Fetch Static Arrays Test") {
//            fetchArrays()
//        }
    }
    
    
    func tupleBridge() {
        let exampleTuple:(CInt, CInt, CInt, CInt) = (34, 82, 18812,9122)
        let tupleBridge = TupleBridgeArrayBased(tuple: exampleTuple, count: 4, type: CInt.self)
        tupleBridge.printMe()
        tupleBridge.erasedForCExample()
        var inoutTuple:(CInt, CInt, CInt, CInt) = (0, 0, 0,0)
        print(inoutTuple)
        tupleBridge.loadIntoTupleFromArray(tuple: &inoutTuple, count: 4, type: CInt.self)
        print(inoutTuple)
        
        var destTuple:(CInt, CInt, CInt, CInt) = (0, 0, 0,0)
        print(destTuple)
        tupleBridge.memCopyToTuple(tuple: &destTuple, count: 4, type: CInt.self)
        print(destTuple)
    }

    func fetchArrays() {
    //        let data = handy.fetchBaseBuffer()
    //        print(data)
    //
    //        let data_32 = handy.fetchBaseBufferRGBA()
    //        for value in data_32 {
    //            print(String(format:"0x%08X", value), terminator: "\t")
    //        }
    //        print()
        
    //        let data_16 = handy.bufferSetToHigh(count: 20, ofType: Double.self)
        //print(data_16)
        
//        let another = handy.makeArrayOfRandomIntClosure(count: 7)
//        print(another)
        
    //        print("expecting string return: \(handy.getString())")
        
    //        print(handy.pointToType())
    //
    //        handy.tupleEraser()
    //        handy.extractStructItem()
    }

}


struct HandyFunctionsView_Previews: PreviewProvider {
    static var previews: some View {
        HandyFunctionsView()
    }
}
