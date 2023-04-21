//
//  OnboardingViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

class RegistViewModel: ObservableObject {

    @Published private var model = OnboardingModel()

    var startWorkTime: String = ""
    var endWorkTime: String = ""
    var name = ""
    var nfcID = ""
    var workingTime = 8.0
    var lunchTime = 1.0

}
