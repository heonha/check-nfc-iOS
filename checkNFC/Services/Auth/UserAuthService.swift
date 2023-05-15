//
//  UserAuthService.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/27.
//

import SwiftUI

class UserAuthService: ObservableObject {

    static let shared = UserAuthService()

    @Published private var userSession: UserInfo? = nil
    @Published private var isUserSignin = false
    @AppStorage("user") private var userData: Data? {
        didSet {
            reloadUserSession()
        }
    }


    private init() {
        if let storedData = userData {
            let user = try? JSONDecoder().decode(UserInfo.self, from: storedData)
            self.userSession = user
        }
    }

    // MARK: Public
    func getUserData() -> UserInfo? {
        if userSession == nil {
            return nil
        } else {
            return userSession
        }
    }

    func resetSession() {
        self.userData = nil
        self.userSession = nil
    }

    func setRegistUser(name: String, workInfo: WorkInfo?, tagInfo: TagInfo, nfcInfo: NFCTagInfo?) {
        registUser(name: name, workInfo: workInfo, tagInfo: tagInfo, nfcInfo: nfcInfo)
    }


    // MARK: Logics
    private func setUserData(data: Data?) {
        return self.userData = data
    }

    private func reloadUserSession() {
        if let storedData = userData {
            let user = try? JSONDecoder().decode(UserInfo.self, from: storedData)
            self.userSession = user
            self.isUserSignin = true
        }
    }

    private func registUser(name: String, workInfo: WorkInfo?, tagInfo: TagInfo, nfcInfo: NFCTagInfo?) {

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

