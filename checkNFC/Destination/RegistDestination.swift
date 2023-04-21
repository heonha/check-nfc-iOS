//
//  RegistDestination.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/21.
//

import SwiftUI

enum RegistDestination: Destination {

    case none, welcome, name, time, nfc

    @ViewBuilder
    var view: some View {
        switch self {
        case .none:
            EmptyView()
        case .welcome:
            RegistWelcomeView()
        case .name:
            RegistNameView()
        case .time:
            RegistTimeView()
        case .nfc:
            RegistNFCView()
        }
    }

}
