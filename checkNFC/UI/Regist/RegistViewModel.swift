//
//  OnboardingViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

class RegistViewModel: ViewModelBase {

    private let nfcService = NFCTagReader()

    private var name: String = ""
    private var workingTime = 8.0
    private var lunchTime = 1.0
    private var nfcTagInfo: NFCTagInfo?
    private var workInfo: WorkInfo?
    var tagInfo: TagInfo = .none

    override init() {
        super.init()
    }

    func settedTag(_ tag: NFCTagInfo) {
        print("Tag Setted: \(tag.tagID)")
        DispatchQueue.main.async {
            self.nfcTagInfo = tag
        }
    }

    func setName(name: String) {
        self.name = name
    }

    func registTag() {
        self.nfcService.scanTag()
    }

    func registUser(withTag tagInfo: TagInfo) {
        
        self.tagInfo = .nfcTag
        UserAuthService.shared.registUser(name: name, workInfo: workInfo, tagInfo: tagInfo, nfcInfo: nfcTagInfo)
    }

    func setWorkInfo(workingTime working: CGFloat, lunchTime lunch: CGFloat) {
        self.workingTime = working
        self.lunchTime = lunch
        self.workInfo = WorkInfo(workingTime: workingTime, lunchTime: lunchTime, dinnerTime: nil)
    }

}
