////
////  NFCNDEFReader.swift
////  checkNFC
////
////  Created by Heonjin Ha on 2023/03/29.
////
//
//import SwiftUI
//import CoreNFC
//
//final class NFCNDEFReader: NSObject, NFCNDEFReaderSessionDelegate {
//
//    override init() {
//
//    }
//
//    var nfcSession: NFCNDEFReaderSession?
//
//    func scan() {
//        nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
//        nfcSession?.alertMessage = "NFC 태그에 아이폰을 접촉해주세요."
//        nfcSession?.begin()
//    }
//
//    func getNFCID() {
//        
//    }
//
//    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
//        
//    }
//
//    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) { }
//
//    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//
//
//    }
//
////    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
////        if tags.count > 1 { // 태그가 둘이상 감지되면
////            let retryInterval = DispatchTimeInterval.milliseconds(500)
////            session.alertMessage = "2개 이상의 태그가 접촉되었습니다. 다시 시도해주세요."
////            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
////                session.restartPolling()
////            })
////            return
////        }
////        print(tags)
////
////        let tag = tags.first!
////
////        session.connect(to: tag) { error in
////            if error != nil {
////                session.alertMessage = "connect 에러 발생: \(error!.localizedDescription)"
////                session.invalidate()
////                return
////            }
////
////
////            tag.readNDEF { message, error in
////
////
////                if let error = error {
////                    session.alertMessage = "readNDEF: \(error.localizedDescription)"
////                    session.invalidate()
////                    return
////                }
////
////                guard let message = message else { return }
////                let nfcID = message.records.first?.payload.base64EncodedString()
////                let nfcData = ["id" : nfcID] as? [AnyHashable : String]
////
////                let notification = Notification(name: Notification.Name("readedNFCID"), object: nil, userInfo: nfcData)
////                NotificationCenter.default.post(notification)
////
////                session.alertMessage = "NFC 체크 완료!"
////                session.invalidate()
////
////            }
////        }
////    }
//
//    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
//        guard let tag = tags.first else {
//            return
//        }
//
//        session.connect(to: tag) { error in
//            if error != nil {
//                session.invalidate(errorMessage: "Connection error. Please try again.")
//                return
//            }
//
//
//
//        }
//    }
//
//    func readNFCTagHandler(session: NFCNDEFReaderSession, tag: NFCNDEFTag, completion: (Result<String, Error>) -> Void) {
//
//
//    }
//
//}
//
//extension Data {
//    func hexEncodedString() -> String {
//        let hexDigits = Array("0123456789abcdef".utf16)
//        var hexChars = [UTF16.CodeUnit]()
//        hexChars.reserveCapacity(count * 2)
//        for byte in self {
//            let (index1, index2) = Int(byte).quotientAndRemainder(dividingBy: 16)
//            hexChars.append(hexDigits[index1])
//            hexChars.append(hexDigits[index2])
//        }
//        return String(utf16CodeUnits: hexChars, count: hexChars.count)
//    }
//}
