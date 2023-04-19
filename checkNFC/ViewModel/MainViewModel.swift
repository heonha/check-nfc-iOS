//
//  NFCViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

final class MainViewModel: ObservableObject {

    static let shared = MainViewModel()

    @AppStorage("userID") var userID = ""

    private init() {

    }

    var nfcReader = NFCNDEFReader.shared

}
