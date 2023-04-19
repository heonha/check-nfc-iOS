//
//  OnboardingViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

enum OnboardingSelection: Hashable {
    case welcome
    case name
    case time
    case nfc
}



final class OnboardingViewModel: ObservableObject, CircularClockViewProtocol {

    @Published private var model = OnboardingModel()

    var selection: OnboardingSelection = .welcome

    var startWorkTime: String = ""
    var endWorkTime: String = ""
    var name = ""
    var nfcID = ""
    var workingTime = 8.0
    var lunchTime = 1.0
    var animationValue: CGFloat = 0

    static let shared = OnboardingViewModel()

    private init() {
        
    }

}
