//
//  HomeViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/27.
//

import SwiftUI

class HomeViewModel: ViewModelBase {

    static let shared = HomeViewModel()

    @ObservedObject private var authService = UserAuthService.shared

    private override init() {
        super.init()
    }

    func getUserData() -> UserInfo? {
        return authService.getUserData()
    }
    
    func getUserName() -> String {
        return authService.getUserData()?.name ?? ""
    }

    func resetUserSession() {
        authService.resetSession()
    }

}
