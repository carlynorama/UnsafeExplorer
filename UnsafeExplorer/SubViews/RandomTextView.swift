//
//  RandomTextView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 3/31/23.
//

import SwiftUI
import UWCSampler

struct RandomTextView: View {
    var rand = RandomProvider()
    @State var message:String = " "
    @State var randomLetters:String = " "
    @State var scrambledMessage:String = " "
    @State var messageToScramble:String = "Test this"
    
    var body: some View {
        VStack {
            Text("Random Text")
            Text(message)
            Button("Generate Message") {
                message = rand.getAnswer()
            }
            Text(randomLetters)
            Button("Add Letter") {
                appendLetter()
            }
            //TextField("title", text: $messageToScramble)
            Text(scrambledMessage)
            Button("Scramble") {
                scrambleMessage(messageToScramble)
            }
            Text(" ")
            Button("print sending test & receiving test") {
                stringFuncs()
            }
            Button("Dump arrays to hex") {
                getHexDumps()
            }
        }
    }
    
    func appendLetter() {
        randomLetters.append(rand.randomLetter())
    }
    
    func stringFuncs() {
        rand.cPrintMessage(message: "Test")
        print(rand.getString())
    }
    
    //TODO: What the heck??!!
    //TODO: Is this behaving differently on Intel and M1?
    func scrambleMessage(_ toScramble:String) {
        //"bcdefghijklmopq"
        scrambledMessage =      rand.scrambleMessage(message: "abcdefghijklmop")
        // fails at 15 chars + 0?
        //Pointer error in there somewhere?
        //"abcdefghi" only 9 chars when from the text field?
        //abcdefghijklmop\357\340\351\350S ?? where did those come from?
    }
    
    func getHexDumps() {
        
        let array1 = ["Hello", "how", "are", "you?"]
        let array2 = rand.makeArrayOfRandomInRange(min: 0, max: CInt.max, count: 10)
        let array3 = [ExampleStruct(), ExampleStruct(), ExampleStruct()]
        
        rand.cPrintHexAnyArray(array1)
        rand.cPrintHexAnyArray(array2)
        rand.cPrintHexAnyArray(array3)
        
    }
    
    
}

fileprivate struct ExampleStruct {
    let myNumber:CInt = 42
    let myString:String = "Hello"
    let color:Color = .brown
    let color2:Color = Color(cgColor: CGColor(red: 255, green: 255, blue: 255, alpha: 255))
}

struct RandomTextView_Previews: PreviewProvider {
    static var previews: some View {
        RandomTextView()
    }
}
