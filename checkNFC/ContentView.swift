//
//  ContentView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SummeryViewContainer()
                .tabItem {
                    Image(systemName: "checkmark.seal")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
