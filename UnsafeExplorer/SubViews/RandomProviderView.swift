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
    var body: some View {
        VStack {
            Text("RandomProviderView")
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
        }
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

    }
}

struct RandomProviderView_Previews: PreviewProvider {
    static var previews: some View {
        RandomProviderView()
    }
}
