//
//  Date+Extension.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/05/09.
//

import Foundation

extension Date {

    var string: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        let dateString = formatter.string(from: self)
        return dateString
    }

}
