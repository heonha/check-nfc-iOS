//
//  UserAuthService.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/27.
//

import SwiftUI

class UserAuthService: ObservableObject {

    static let shared = UserAuthService()

    @Published var user: UserInfo?

    private init() {
        if let userData = UserDefaults.standard.value(forKey: "user") as? UserInfo {
            self.user = userData
        }
    }

}
