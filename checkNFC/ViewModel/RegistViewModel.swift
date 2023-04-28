//
//  OnboardingViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

class RegistViewModel: ObservableObject {

    @Published private var model = OnboardingModel()
    let nfcService = NFCManageService()

    var name: String = ""
    var workingTime = 8.0
    var lunchTime = 1.0

    private var workInfo: WorkInfo?
    private var tagInfo: TagInfo = .none
    @Published var userInfo: UserInfo?


    func registUserWithNFC() {
        self.tagInfo = .nfcTag
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        let user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        self.userInfo = user
        UserAuthService.shared.user = user

        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: "user")
        } catch {
            print("Failed to save user data: \(error.localizedDescription)")
        }

    }

    func registUserWithoutNFC() {
        self.tagInfo = .none
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        let user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        self.userInfo = user
        UserAuthService.shared.user = user

        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: "user")
        } catch {
            print("Failed to save user data: \(error.localizedDescription)")
        }

    }

    func setUserInfo() {
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        let user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        self.userInfo = user
        UserAuthService.shared.user = user
        UserDefaults.standard.setValue(user, forKey: "user")
    }

    func setWorkInfo() {
        self.workInfo = WorkInfo(workingTime: workingTime, lunchTime: lunchTime, dinnerTime: nil)
    }

}
