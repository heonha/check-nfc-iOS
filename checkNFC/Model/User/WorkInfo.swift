//
//  WorkInfo.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/19.
//

import Foundation

struct WorkInfo: Codable {
    let workingTime: CGFloat
    let lunchTime: CGFloat
    let dinnerTime: CGFloat?
}
