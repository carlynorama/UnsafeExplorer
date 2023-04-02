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
}

struct RandomTextView_Previews: PreviewProvider {
    static var previews: some View {
        RandomTextView()
    }
}
