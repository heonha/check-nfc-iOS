//
//  NFCViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

final class MainViewModel: ObservableObject {

    static let shared = MainViewModel()

    private init() {

    }

    @Published var nfcReader = NFCNDEFReader.shared

}
