//
//  NFCNDEFReader.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import CoreNFC

final class NFCNDEFReader: NSObject, NFCNDEFReaderSessionDelegate {

    static let shared = NFCNDEFReader()

    private override init() {

    }

    var nfcSession: NFCNDEFReaderSession?

    func scan() {
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "NFC 태그에 아이폰을 접촉해주세요."
        nfcSession?.begin()
    }

    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) { }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) { }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 { // 태그가 둘이상 감지되면
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "2개 이상의 태그가 접촉되었습니다. 다시 시도해주세요."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }

        let tag = tags.first!
        session.connect(to: tag) { error in
            if error != nil {
                session.alertMessage = "connect 에러 발생: \(error!.localizedDescription)"
                session.invalidate()
                return
            }

            print("태그 연결완료")

            tag.readNDEF { message, error in
                if error != nil {
                    session.alertMessage = "readNDEF 에러 발생 : \(error!.localizedDescription)"
                    session.invalidate()
                    return
                }
                let tagID = message?.records.first?.payload.base64EncodedString()
                print(tagID)
                session.alertMessage = "NFC 체크 완료!"
                session.invalidate()

                return
            }

        }
    }
}
