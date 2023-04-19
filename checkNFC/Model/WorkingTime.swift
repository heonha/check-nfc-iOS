//
//  WorkingTime.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/19.
//

import Foundation

struct WorkingTime: Identifiable {
    let id: UUID
    let startDate: Date
    var startTimeInterval: CGFloat
    var endTimeInterval: CGFloat
    var totalWorkTime: CGFloat
}
