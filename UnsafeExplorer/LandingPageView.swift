//
//  TabView.swift
//  UnsafeExplorer
//
//  Created by Carlyn Maw on 3/31/23.
//

import SwiftUI
import UWCSampler

struct LandingPageView: View {
    var body: some View {
        TabView {
            RandomProviderView()
                .tabItem {
                    Label("Random Numbers", systemImage: "tray.and.arrow.down.fill")
                }
            RandomTextView()
                .tabItem {
                    Label("Random Text", systemImage: "tray.and.arrow.up.fill")
                }
            RandomColorsView()
                .tabItem {
                    Label("Union Color Type", systemImage: "person.crop.circle.fill")
                }
            PseudoUnionView()
                .tabItem {
                    Label("PseudoUnionView", systemImage: "person.crop.circle.fill")
                }
            HandyFunctionsView()
                .tabItem {
                    Label("HandyFunctionsView", systemImage: "person.crop.circle.fill")
                }
            OpaquePointersView()
                .tabItem {
                    Label("OpaquePointersView", systemImage: "person.crop.circle.fill")
                }
        }.padding(20)
    }

}


struct RandomColorsView: View {
    var body: some View {
        Text("RandomColorView")
    }
}

struct PseudoUnionView: View {
    var body: some View {
        Text("PseudoUnion")
    }
}

struct OpaquePointersView: View {
    var body: some View {
        Text("OpaquePointersView")
    }
}

struct HandyFunctionsView: View {
    var body: some View {
        Text("HandyFunctionsView")
    }
}


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
