//
//  HomeViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/27.
//

import SwiftUI

class HomeViewModel: MainViewModel {

    static let shared = HomeViewModel()

    @ObservedObject private var authService = UserAuthService.shared

    private override init() {
        super.init()
    }


    func getUserData() -> UserInfo? {
        return authService.userSession
    }

    func checkNFC() {

    }


    func resetUserSession() {
        authService.userSession = nil
        authService.userData = nil
    }


}
