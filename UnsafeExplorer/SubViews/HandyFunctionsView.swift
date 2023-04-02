//
//  HandyFunctionsView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/1/23.
//

import SwiftUI
import UWCSampler

//Example code using MiscHandy and TupleBridge

struct HandyFunctionsView: View {
    let handy = MiscHandy()
    var body: some View {
        VStack {
            
            Button("Fetch Static Arrays Tests") {
                fetchArrays()
            }
            
            Button("Test Assembler") {
                exampleAssemblerTest()
            }
            
            Button("TupleBridge Tests") {
                tupleBridgeTests()
            }
            
            Button("Process Data") {
                processDataTest()
                processOffsetDataTest()
                loadArraysTest()
            }
            
            Button("Digging inside a Struct Tests") {
                structItems()
            }
            
            
        }
    }
    
    
    
    func fetchArrays() {
        let data = handy.fetchBaseBuffer()
        print(data)
        
        let data_32 = handy.fetchBaseBufferRGBA()
        for value in data_32 {
            print(String(format:"0x%08X", value), terminator: "\t")
        }
        print()
    }
    
    func exampleAssemblerTest() {
        let data:[CInt] = [3000, 16000, 24987, 7, CInt.max, CInt.min]
        let header = ThisHeader(id: 255, value: UInt32.max, whyNotLetsTry: "AAAAAAA")
        
        handy.exampleAssembler(header: header, data: data)
    }
    
    func processDataTest() {
        
        let data_n32 = Data([92, 39, 47, 3])
        let number_perfectfit = handy.processData(data: data_n32, as: UInt32.self)
        
        
        let data_n64 = Data([92, 39, 47,3, 72, 4, 171, 71])
        let number_tooMany = handy.processData(data: data_n64, as: UInt32.self)
        
        let intoTuple = handy.processData(data: data_n64, as: (UInt32, UInt32).self)
        
        //Nope. Thread 1: EXC_BAD_ACCESS (code=1, address=0x7ab0448032f2758)
        //        let intoArray = handy.processData(data: data_n64, as: [UInt32].self)
        
        //Also nope. Thread 1: Fatal error: UnsafeRawBufferPointer.load out of bounds with 0
        //EXC_BAD_ACCESS without.
        //        if var data_s = "Oh what a beautiful morning! Oh what a beautiful day.".data(using: .utf8) {
        //            //data_s.append(0)
        //            let string:String =  handy.processData(data: data_s, as: String.self)
        //        }
        
        var header = ThisHeader(id: 255, value: UInt32.max, whyNotLetsTry: "AAAAAAA")
        let byteCount = MemoryLayout.size(ofValue: header)
        
        let data_h = withUnsafeMutablePointer(to: &header) { pointer in
            let raw = UnsafeMutableRawPointer(pointer)
            return Data(bytesNoCopy: raw, count: byteCount, deallocator: .none) //.none??? Whose's in charge??
                                                                                //Note there is also Data(bytes: T##UnsafeRawPointer, count: T##Int) what does copy the bytes and allows for the use of UnsafePointer instead of mutable.
        }
        
        let intoStruct = handy.processData(data: data_h, as: ThisHeader.self)
        
        
        print(number_perfectfit, number_tooMany, intoTuple, intoStruct)
        
        
    }
    
    
    func processOffsetDataTest() {
        
        print("-------- processOffsetDataTest")
        let data_n32 = Data([255, 255, 47,3, 172, 4])
        let data_n64 = Data([92, 39, 47,3, 172, 4, 160, 71])
        
        //Nope: Swift/UnsafeRawPointer.swift:421: Fatal error: load from misaligned raw pointer
        //In both these cases
        //let number_tooMany = handy.processData2(data: data_n64, as: UInt32.self, offsetBy: 2)
        //let number_perfectfit = handy.processData2(data: data_n32, as: UInt32.self, offsetBy: 2)
        
        //Works because UInt16 is 2
        let intoTuple_2 = handy.processData2(data: data_n64, as: (UInt16, UInt16).self, offsetBy: 2)
        let intoTuple_4 = handy.processData2(data: data_n64, as: (UInt16, UInt16).self, offsetBy: 4)
        // Again, no.
        //let intoTuple_3 = handy.processData2(data: data_n64, as: (UInt16, UInt16).self, offsetBy: 3)
        
        //Using .loadUnaligned fixes that.
        let number_tooMany = handy.processUnalignedData(data: data_n64, as: UInt32.self, offsetBy: 2)
        let number_perfectfit = handy.processUnalignedData(data: data_n32, as: UInt32.self, offsetBy: 2)
        let intoTuple_3 = handy.processUnalignedData(data: data_n64, as: (UInt16, UInt16).self, offsetBy: 3)
        
        print("Confirmed received:", terminator: " ")
        print(number_perfectfit, number_tooMany, intoTuple_2, intoTuple_4, intoTuple_3)
        
        
    }
    
    func loadArraysTest() {
        print("-------- loadArraysTest")
        let data_n64 = Data([92, 39, 47,3, 172, 4, 160, 71])
        let intoArray = handy.processDataIntoArray(data: data_n64, as: UInt32.self, count: 2)
        
        let unAligned = handy.processUnalignedDataIntoArray(data: data_n64, as: UInt16.self, byOffset:1, count: 3)
        
        print(intoArray, unAligned)
        //Does fail.
        //let shouldFail = handy.processUnalignedDataIntoArray(data: data_n64, as: UInt16.self, byOffset:1, count: 4)
        
    }
    
    func structItems() {
        
        handy.conveniencePointerToStructItem()
        handy.calculatedPointerToStructItem()
        
        
        //        var header = ThisHeader(id: 255, value: UInt32.max, whyNotLetsTry: "AAAAAAA")
        //        let byteCount = MemoryLayout.size(ofValue: header)
        
        //        let data_h = withUnsafeMutablePointer(to: &header) { pointer in
        //            let raw = UnsafeMutableRawPointer(pointer)
        //            return Data(bytesNoCopy: raw, count: byteCount, deallocator: .none)
        //            //Note there is also Data(bytes: T##UnsafeRawPointer, count: T##Int) what does copy the bytes and allows for the use of UnsafePointer instead of mutable.
        //        }
        //
        //        let intoStruct = handy.processData2(data: data_h, as: ThisHeader.self)
    }
    
    
    
    func tupleBridgeTests() {
        
        let exampleTuple:(CInt, CInt, CInt, CInt) = (34, 82, 18812,9122)
        let tupleBridge = TupleBridge(tuple: exampleTuple, count: 4, type: CInt.self)
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
    
    
    
}

fileprivate struct ThisHeader {
    let id:UInt8
    let value:UInt32
    let whyNotLetsTry:String
}


struct HandyFunctionsView_Previews: PreviewProvider {
    static var previews: some View {
        HandyFunctionsView()
    }
}
