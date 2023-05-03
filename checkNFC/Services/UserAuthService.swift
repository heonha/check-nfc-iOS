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
            reloadUserSession()
        }
    }

    init() {
        if let storedData = userData {
            let user = try? JSONDecoder().decode(UserInfo.self, from: storedData)
            self.userSession = user
        }
    }

    func reloadUserSession() {
        if let storedData = userData {
            let user = try? JSONDecoder().decode(UserInfo.self, from: storedData)
            self.userSession = user
        }
    }

    func registUser(name: String, workInfo: WorkInfo?, tagInfo: TagInfo, nfcInfo: NFCTagInfo?) {

        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        var user: UserInfo?


        if nfcInfo == nil {
            user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        } else {
            user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo, nfcInfo: nfcInfo)
        }

        do {
            let encodedUserData = try JSONEncoder().encode(user)
            UserAuthService.shared.userData = encodedUserData
        } catch {
            print("UserData Encode Error: \(error.localizedDescription)")
            return
        }
    }

}
