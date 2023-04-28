//
//  MainView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/21.
//

import SwiftUI

struct MainView: View {

    @ObservedObject var viewModel = HomeViewModel.shared
    @ObservedObject var authService = UserAuthService.shared

    var body: some View {
        if authService.user == nil {
            RegistContainerView()
        } else {
            DashboardView()
                .environmentObject(viewModel)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
