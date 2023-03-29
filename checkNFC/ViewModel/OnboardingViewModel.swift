//
//  OnboardingViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {

    @Published var name = ""
    @Published var nfcID = ""
    @Published var workingTime = 8.0
    @Published var lunchTime = 1.0

    @Published var animationValue: CGFloat = 0


}
