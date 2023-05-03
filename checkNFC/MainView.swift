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
        ZStack {

            if authService.userData == nil {
                RegistContainerView()
            } else {
                DashboardView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            // MARK: Debugging
            print("USER: \(authService.userSession?.id)")
            if let userData = authService.userData {
                let user = try? JSONDecoder().decode(UserInfo.self, from: userData)
                print(user)
            }
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
