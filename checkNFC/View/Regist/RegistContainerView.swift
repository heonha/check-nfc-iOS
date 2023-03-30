//
//  RegistContainerView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistContainerView: View {

    @StateObject var viewModel = OnboardingViewModel.shared

    var body: some View {
        TabView(selection: $viewModel.selection) {
            RegistWelcomeView(viewModel: viewModel)
                .tag(OnboardingSelection.welcome)
            RegistNameView(viewModel: viewModel)
                .tag(OnboardingSelection.name)
            RegistTimeView(viewModel: viewModel)
                .tag(OnboardingSelection.time)
            RegistNFCView(viewModel: viewModel)
                .tag(OnboardingSelection.nfc)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))


    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RegistContainerView()
    }
}
