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
            MainViewContainer()
                .tabItem {
                    Image(systemName: "checkmark.seal")
                }
            OnboardingView()
                .tabItem {
                    Image(systemName: "xmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
