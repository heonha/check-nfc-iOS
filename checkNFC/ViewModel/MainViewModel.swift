//
//  NFCViewModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import SwiftNFC

final class MainViewModel: ObservableObject {

    @Published var nfcReader = NFCNDEFReader.shared

}
