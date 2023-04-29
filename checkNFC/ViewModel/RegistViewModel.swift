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
   
        UserAuthService.shared.registUser(name: name, workInfo: workInfo, tagInfo: tagInfo, nfcInfo: nfcTagInfo)
        // MARK: 세션 저장하기

    }

    func registUserWithoutNFC() {
        self.tagInfo = .none
        guard let workInfo = workInfo else {
            print("workInfo is nil")
            return
        }

        UserAuthService.shared.registUser(name: name, workInfo: workInfo, tagInfo: tagInfo, nfcInfo: nil)
    }

    func setWorkInfo(workingTime working: CGFloat, lunchTime lunch: CGFloat) {
        self.workingTime = working
        self.lunchTime = lunch
        self.workInfo = WorkInfo(workingTime: workingTime, lunchTime: lunchTime, dinnerTime: nil)
    }



}
