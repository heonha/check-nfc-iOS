////
////  NFCViewModel.swift
////  checkNFC
////
////  Created by Heonjin Ha on 2023/03/29.
////
//
//import SwiftUI
//import SwiftNFC
//
//final class NFCViewModel: ObservableObject {
//
//    @ObservedObject var NFCR = NFCReader()
//    @ObservedObject var NFCW = NFCWriter()
//
//    func read() {
//        NFCR.read()
//    }
//
//    func write() {
//        NFCW.msg = NFCR.msg
//        NFCW.write()
//    }
//
//
//}
