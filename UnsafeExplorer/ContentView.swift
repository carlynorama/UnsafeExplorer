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
            Button("Fetch array") {
                fetchArrays()
            }
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
        let vals = rand.makeArrayOfRandomInRangeExplicitPointers(min: 45, max: 234, count: 12)
        print(vals)
        
        let vals2 = rand.addRandomTo([345, 773, 983, 8827, 1], upTo:50)
        print(vals2)
        
        //rand.testBufferProcess()
        
        let newBuffer = rand.processBuffer()
        print(newBuffer)
        
        //rand.cPrintMessage(message:"Hello from c")
        message = rand.getAnswer()
    }
    
    func fetchArrays() {
        let data = rand.fetchBaseBuffer()
        print(data)
        
        let data_32 = rand.fetchBaseBufferRGBA()
        for value in data_32 {
            print(String(format:"0x%08X", value), terminator: "\t")
        }
        print()
        
        let data_16 = rand.bufferSetToHigh(count: 20, ofType: Double.self)
        print(data_16)
        
        let another = rand.makeArrayOfRandomIntClosure(count: 7)
        print(another)
        
        print("expecting string return: \(rand.getString())")
        
        print(rand.pointToType())
        
        rand.tupleEraser()
        rand.extractStructItem()
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
