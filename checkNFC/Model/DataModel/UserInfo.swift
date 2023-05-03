//
//  UserData.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/19.
//

import Foundation

struct UserInfo: Identifiable, Codable {
    let id: String
    let name: String
    let workInfo: WorkInfo
    let workTimes: [WorkingTime]?
    let tagInfo: TagInfo
    var nfcInfo: NFCTagInfo?
}

