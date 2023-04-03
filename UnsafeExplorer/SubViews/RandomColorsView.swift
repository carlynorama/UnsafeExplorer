//
//  RandomColorsView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 4/1/23.
//

import SwiftUI
import UWCSampler


struct RandomColorsView: View {
    var rand = RandomProvider()
    @State var generatedColor:Color = .clear
    @State var colors:[Color] = [ .red, .green, .blue]
    @State var c_colors:[Color] = [ .red, .green, .blue]
    
    
    func seeNoC() {
        //without import UWCSamplerC, cant call C functions
        random_int()
    }
    
    var body: some View {
        VStack {
            
            generatedColor
            Button("Update Color") {
                updateColor()
            }
            Button("Run Test Functions") {
                testColorFunctions()
            }
            HStack {
                //colors are not guaranteed to be unique so ForEach(color, id: \.self) is not adequate.
                //Can't use colors.indices() b/c not a constant value.
                //An aray of a zip is better, but in fact not ideal solution in
                //this case b/c forced to use .0 (not stable, color at index can change)
                //since can't use \.self because Color isn't hashable.
                //or \.1 since Color isn't Identifiable.
                //ForEach is a view manager so it is very sensitive to changes
                // consider color.id(UUID()) if problems arise.
                //See https://developer.apple.com/videos/play/wwdc2021/10022/
                ForEach(Array(zip(colors.indices, colors)), id: \.0) { index, color in
                    color//.id(UUID())
                }
                
            }
            Button("Load Colors from Int") {
                loadColorArray()
            }
            HStack {
                //Alternative (.enumerated) to zip available to Arrays
                //are a zero-based, integer-indexed collections (Array)
                //This solution should be the less flakey.
                ForEach(Array(c_colors.enumerated()), id: \.element) { index, color in
                    color
                }
            }
            Button("Load Colors from CColor") {
                loadCColorArray()
            }
        }.padding(20)
    }
    
    func updateColor() {
        generatedColor = uint32ToColor(0x6666FFFF)
    }
    
    func loadColorArray() {
        colors = rand.makeRandomUInt32Buffer(count:20).map {
            uint32ToColor($0)
        }
    }
    
    func loadCColorArray() {
        c_colors = rand.castUInt32BufferAsColors(rand.makeRandomUInt32Buffer(count:20)).map {
            //uint32ToColor($0.full) //C type available use, but not to declare
            Color(red: Double($0.red)/255.0, green: Double($0.green)/255.0, blue: Double($0.blue)/255.0, opacity: Double($0.alpha)/255.0)
        }
    }
    
    
    
    func testColorFunctions() {
        print("----------------------------------------")
        rand.printUInt32AsColor(colorInt: 0xFF00CC33)
        let buffer = rand.makeRandomUInt32Buffer(count:20)
        rand.printUInt32BufferAsColor(buffer)
        print("----------")
        
        //C type available use, but not to declare
        var c_color = rand.makeAndVerifyCColor(0xCCFF3366)
        c_color.red = 0
        rand.printCColorRGBA(c_color)
        // -> since no C import can't do `let color = CColorRGBA(full: colorInt)` here.
        print("----------")
        let castBuffer = rand.castUInt32BufferAsColors(buffer)
        rand.printCColorRGBABuffer(castBuffer)
        
        rand.testTransfer()
        
    }
    
    func getComponent(from thisInt:UInt32, position:Int) -> Double {
        return Double((thisInt >> (position * 8)) & 0xFF)/255.0
    }
    
    
    func uint32ToColor(_ thisInt:UInt32) -> Color {
        Color(
            red: getComponent(from: thisInt, position: 3),
            green: getComponent(from: thisInt, position: 2),
            blue: getComponent(from: thisInt, position: 1),
            opacity: getComponent(from: thisInt, position: 0)
        )
    }
}

struct RandomColorsView_Previews: PreviewProvider {
    static var previews: some View {
        RandomColorsView()
    }
}
