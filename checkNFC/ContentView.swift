//
//  ContentView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/28.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {

        if viewModel.userID.isEmpty {
            RegistContainerView()
        } else {
            MainViewContainer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
