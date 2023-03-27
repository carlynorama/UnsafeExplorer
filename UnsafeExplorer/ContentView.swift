//
//  ContentView.swift
//  UnsafeExplorer
//
//  Created by Labtanza on 3/25/23.
//

import SwiftUI
import UWCSampler

struct ContentView: View {
    var rand = RandomNumberSetProvider()
    @State var myNum:Int = 0
    
    var body: some View {
        VStack {
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
        }
        .padding()
    }
    
    func updateNumber() {
        myNum = rand.getRandomInt()
    }
    
    func printRandos() {
        let vals = rand.makeArrayOfRandomInt(count:10)
        print(vals)
    }
    
    func printPlusRandos() {
        let vals = rand.randomValueInRange(min: 45, max: 234, count: 12)
        print(vals)
        
        let vals2 = rand.addRandomTo([345, 773, 983, 8827, 1], upTo:50)
        print(vals2)
        
        //rand.testBufferProcess()
        
        let newBuffer = rand.processBuffer()
        print(newBuffer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
