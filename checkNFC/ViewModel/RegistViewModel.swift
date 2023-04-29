//
//  OnboardingViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

class RegistViewModel: MainViewModel, NFCTagReaderDelegate {

    let nfcService = NFCTagReader()

    var name: String = ""
    var workingTime = 8.0
    var lunchTime = 1.0

    var nfcTagInfo: NFCTagInfo?
    var workInfo: WorkInfo?
    var tagInfo: TagInfo = .none
    var userInfo: UserInfo?

    override init() {
        super.init()
        nfcService.delegate = self
    }

    func settedTag(_ tag: NFCTagInfo) {
        print("Tag Setted: \(tag.tagID)")
        DispatchQueue.main.async {
            self.nfcTagInfo = tag
        }
    }

    func registUserWithNFC() {
        self.tagInfo = .nfcTag
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        var user: UserInfo?

        if nfcTagInfo == nil {
            user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        } else {
            user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo, nfcInfo: nfcTagInfo)
        }
        self.userInfo = user

        do {
            let encodedUserData = try JSONEncoder().encode(user)
            UserAuthService.shared.userData = encodedUserData
        } catch {
            print("UserData Encode Error: \(error.localizedDescription)")
            return
        }
        // MARK: 세션 저장하기

    }

    func registUserWithoutNFC() {
        self.tagInfo = .none
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        let user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        self.userInfo = user
        UserAuthService.shared.userSession = user

        // MARK: 세션 저장하기

    }

    func setUserInfo() {
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        let user = UserInfo(id: UUID().uuidString, name: name, workInfo: workInfo, workTimes: nil, tagInfo: tagInfo)
        self.userInfo = user
        UserAuthService.shared.userSession = user
        UserDefaults.standard.setValue(user, forKey: "user")
    }

    func setWorkInfo(workingTime working: CGFloat, lunchTime lunch: CGFloat) {
        self.workingTime = working
        self.lunchTime = lunch
        self.workInfo = WorkInfo(workingTime: workingTime, lunchTime: lunchTime, dinnerTime: nil)
    }

    func saveUserSession(user: UserInfo?) {
        do {
            let encodedUserData = try JSONEncoder().encode(user)
            UserAuthService.shared.userData = encodedUserData
        } catch {
            print("UserData Encode Error: \(error.localizedDescription)")
            return
        }
    }

}
