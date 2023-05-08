//
//  NFCTagType.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/05/08.
//

import Foundation

enum NFCTagType: Codable {
    case MiFare
    case FeliCa
    case iso15693
    case iso7816
}
