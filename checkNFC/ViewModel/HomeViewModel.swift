//
//  HomeViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/27.
//

import SwiftUI

class HomeViewModel: MainViewModel {

    static let shared = HomeViewModel()

    @EnvironmentObject var authService: UserAuthService

    private override init() {
        super.init()
    }

    func checkNFC() {

    }

}
