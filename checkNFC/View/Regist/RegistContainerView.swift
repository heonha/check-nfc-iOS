//
//  RegistContainerView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistContainerView: View {
    var body: some View {
        NavigationView {
            RegistWelcomeView(viewModel: OnboardingViewModel.shared)
        }
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RegistContainerView()
    }
}
