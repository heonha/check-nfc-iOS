//
//  RegistContainerView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistContainerView: View {

    @StateObject private var viewModel = RegistViewModel()

    var body: some View {
        NavigationView {
            RegistWelcomeView()
        }
        .environmentObject(viewModel)
    }

}
