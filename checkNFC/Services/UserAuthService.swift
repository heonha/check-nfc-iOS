//
//  UserAuthService.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/27.
//

import SwiftUI

class UserAuthService: ObservableObject {

    static let shared = UserAuthService()

    @Published var userSession: UserInfo? = nil
    @AppStorage("user") var userData: Data? {
        didSet {
            reloadUserData()
        }
    }

    init() {
        if let storedData = userData {
            let user = try? JSONDecoder().decode(UserInfo.self, from: storedData)
            self.userSession = user
        }
    }

    func reloadUserData() {
        if let storedData = userData {
            let user = try? JSONDecoder().decode(UserInfo.self, from: storedData)
            self.userSession = user
        }
    }

}
