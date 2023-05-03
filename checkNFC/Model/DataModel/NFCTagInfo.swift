//
//  NFCTagInfo.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/19.
//

import Foundation

struct NFCTagInfo: Codable {
    let tagID: String
    let tagType: NFCTagType
}
