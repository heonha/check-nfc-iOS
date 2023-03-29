//
//  NFCNDEFReader.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import CoreNFC

final class NFCNDEFReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {

    var theactualData = "" // 작성될 URL 전달함
    var nfcSession: NFCNDEFReaderSession?

    func scan(theactualData: String) {
        self.theactualData = theactualData
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "NFC 태그에 아이폰을 접촉해주세요."
        nfcSession?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) { }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {}

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let str: String = theactualData
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
                session.alertMessage = "에러 발생: \(error!.localizedDescription)"
                session.invalidate()
                return
            }
            tag.queryNDEFStatus { ndefstatus, capacity, error in
                guard error == nil else {
                    session.alertMessage = "에러발생: \(String(describing: error?.localizedDescription))"
                    session.invalidate()
                    return
                }
                switch ndefstatus {
                case .notSupported: // 해당 태그가 NDEF 형식의 태그가 아님을 나타내는 상태입니다.
                    session.alertMessage = "지원하지 않는 형식의 NFC Tag"
                    session.invalidate()
                    return
                case .readOnly: // 태그가 NDEF 메시지 데이터 읽기만 지원함을 나타내는 상태입니다.
                    session.alertMessage = "읽기만 가능한 형식의 NFC Tag"
                    session.invalidate()
                    return
                case .readWrite: //태그가 NDEF 메시지 데이터 읽기 및 쓰기를 지원함을 나타내는 상태입니다
                    tag.writeNDEF(.init(records: [NFCNDEFPayload.wellKnownTypeURIPayload(string: "\(str)")!])) { error in
                        guard error == nil else {
                            session.alertMessage = "NFC 쓰기 에러"
                            session.invalidate()
                            return
                        }
                        session.alertMessage = "NFC Tagging 성공"
                        session.invalidate() // 리더 세션을 닫아 재사용하지 못하게 합니다.
                    }
                @unknown default:
                    session.alertMessage = "알수없는 에러 발생"
                    session.invalidate() // 리더 세션을 닫아 재사용하지 못하게 합니다.
                    return
                }
            }
        }
    }
}




