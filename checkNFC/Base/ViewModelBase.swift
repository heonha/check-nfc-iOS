//
//  NFCViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

enum AppState {
    case none

}

class ViewModelBase: ObservableObject {

    @Published var appState: AppState = .none

}
