//
//  MainContainerView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/21.
//

import SwiftUI

struct MainContainerView: View {

    @ObservedObject var viewModel = HomeViewModel.shared
    @ObservedObject var authService = UserAuthService.shared

    var body: some View {
        ZStack {

            if authService.getUserData() == nil {
                RegistContainerView()
            } else {
                HomeView()
                    .environmentObject(viewModel)
            }
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
