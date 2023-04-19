//
//  UserData.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/19.
//

import Foundation

// UserData.swift
struct UserData: Identifiable {
    let id: UUID
    let name: String
    let workInfo: WorkInfo
    let workTimes: [WorkingTime]
    let tagInfo: TagInfo
    var nfcInfo: NFCTagInfo?
}
