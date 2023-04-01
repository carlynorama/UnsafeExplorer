//
//  RandomProviderView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 3/31/23.
//

import SwiftUI
import UWCSampler


struct RandomProviderView: View {
    var rand = RandomProvider()
    @State var myNum:Int = 0
    @State var bufferCInt:[CInt] = [0]
    @State var bufferInt:[Int] = [0]
    @State var bufferUInt8:[UInt8] = [0]
    @State var addRandomTo100Text = "100"
//    @State var bufferCIntText = "[0]"
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                Text("RandomProviderView")
                Text("Hello, world! (\(myNum))")
                Button("New Number") {
                    myNum = rand.getRandomIntClosure()
                }
                Text(addRandomTo100Text)
                Button("Add random number to 100, capped at 255") {
                    let randomPositiveNumber:CInt = 100
                    addRandomTo100Text = "\(rand.addRandom(to: randomPositiveNumber, cappingAt: 255)))"
                }
            }
            Spacer()
            Group {
                Text("Ints: \(bufferInt.description)")
                Text("CInts: \(bufferCInt.description)")
                
                Button("Generate Buffers") {
                    bufferCInt = rand.makeArrayOfRandomIntExplicitPointer(count:10).map({CInt($0)})
                    bufferInt = rand.makeArrayOfRandomInRange(min: 30, max: 200, count: 8)
                }
                Button("Generate Buffers") {
                    alterBuffers()
                }
            }
            Spacer()
            Group {
                Text("UInt8s: \(bufferUInt8.description)")
                Button("Fuzz UInt8 Buffer ± 5") {
                    fuzzedBuffer()
                }
            }
            Spacer()
           
        }.onAppear {
            bufferUInt8 = rand.base_buffer
        }
    }
    
 
    
    func alterBuffers() {
        bufferInt = rand.addRandomWithCap(bufferCInt.map({UInt32($0)}), newValueCap: 255).map({Int($0)})
        bufferCInt = rand.addRandomTo(bufferCInt, randomValueUpTo: 10)
    }
    
    func fuzzedBuffer() {
        //rand.testBufferProcess()
        
        let newBuffer:[UInt8] = rand.fuzzedBaseBuffer(fuzzAmount: 5)
        print(newBuffer)
        bufferUInt8 =  newBuffer

    }
}

struct RandomProviderView_Previews: PreviewProvider {
    static var previews: some View {
        RandomProviderView()
    }
}
