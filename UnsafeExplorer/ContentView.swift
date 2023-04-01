//
//  ContentView.swift
//  UnsafeExplorer
//
//  Created by Labtanza on 3/25/23.
//

import SwiftUI
import UWCSampler

struct ContentView: View {
    var rand = RandomProvider()
    @State var myNum:Int = 0
    @State var message = "No message"
    
    var body: some View {
        VStack {
            Text(message)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world! (\(myNum))")
            Button("New Number") {
                updateNumber()
            }
            Button("Print random numbers") {
                printRandos()
            }
            Button("Print random in range") {
                printPlusRandos()
            }
            Button("Tuple Funcs") {
                tupleBridge()
            }
//            Button("Fetch array") {
//                fetchArrays()
//            }
//            Button("Color Funcs") {
//                colorFuncs()
//            }
//            Button("Union Funcs") {
//                pseudoUnionFuncs()
//            }
        }
        .padding()
    }
    
    func updateNumber() {
        //myNum = rand.getRandomInt()
        myNum = rand.getRandomIntClosure()
    }
    
    func printRandos() {
        let vals = rand.makeArrayOfRandomIntExplicitPointer(count:10)
        print(vals)
    }
    
    func printPlusRandos() {
//        let vals = rand.makeArrayOfRandomInRangeExplicitPointers(min: 45, max: 234, count: 12)
//        print(vals)
        
//        let vals2 = rand.addRandomTo([345, 773, 983, 8827, 1], upTo:50)
//        print(vals2)
        
        //rand.testBufferProcess()
        
        let newBuffer = rand.fuzzBuffer()
        print(newBuffer)
        
        //rand.cPrintMessage(message:"Hello from c")
        message = rand.getAnswer()
    }
    
    func fetchArrays() {
//        let data = rand.fetchBaseBuffer()
//        print(data)
//        
//        let data_32 = rand.fetchBaseBufferRGBA()
//        for value in data_32 {
//            print(String(format:"0x%08X", value), terminator: "\t")
//        }
//        print()
        
//        let data_16 = rand.bufferSetToHigh(count: 20, ofType: Double.self)
        //print(data_16)
        
        let another = rand.makeArrayOfRandomIntClosure(count: 7)
        print(another)
        
//        print("expecting string return: \(rand.getString())")
        
//        print(rand.pointToType())
//
//        rand.tupleEraser()
//        rand.extractStructItem()
    }
    
    func colorFuncs() {
//        print("----------------------------------------")
//        rand.printUInt32AsColor(colorInt: 0xFF00CC33)
//        let buffer = rand.makeRandomUInt32Buffer(count:20)
//        rand.printUInt32BufferAsColor(buffer)
//        print("----------")
//        var c_color = rand.makeAndVerifyCColor(0xCCFF3366)
//        c_color.red = 0
//        rand.printCColorRGBA(c_color)
//        print("----------")
//        let castBuffer = rand.castUInt32BufferAsColors(buffer)
//        rand.printCColorRGBABuffer(castBuffer)
        
        rand.testTransfer()

    }
    
    func bridgeColorTests() {
        let bridgeColor:BridgeColor = BridgeColor(red:77, green: 123, blue: 11, alpha: 255)
        
        let val_pt = bridgeColor.asUINT32FromPointerType()
        let val_ctp = bridgeColor.asUINT32FromPointerToConcreteType()
        
        bridgeColor.printExpectedInt()
        print("Pointer typedef = \(String(format:"0x%08x",val_pt))")
        print("Pointer to concrete typedef = \(String(format:"0x%08x",val_ctp))")
        
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
    
}

struct TestCustomStruct {
    let test:Int = 0;
    let test_other:UInt16 = 0;
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
