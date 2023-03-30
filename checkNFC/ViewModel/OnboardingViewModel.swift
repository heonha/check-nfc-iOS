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

    @Published var selection: OnboardingSelection = .welcome

    @Published var startWorkTime: String = ""
    @Published var endWorkTime: String = ""

    @Published var name = ""
    @Published var nfcID = ""
    @Published var workingTime = 8.0
    @Published var lunchTime = 1.0

    @Published var animationValue: CGFloat = 0

    static let shared = OnboardingViewModel()

    private init() {
        
    }

}
