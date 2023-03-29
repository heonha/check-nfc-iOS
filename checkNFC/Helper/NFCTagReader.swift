//
//  NFCTagReader.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import CoreNFC

final class NFCTagReader: NSObject, NFCTagReaderSessionDelegate {

    func scan() {
        let session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
        session?.begin()
    }

    // Error handling again
    // 오류 처리
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {

        print("tagReaderSession")
    }

    // Additionally there's a function that's called when the session begins
    // 또한 세션이 시작될 때 호출되는 함수가 있습니다.
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("tagReaderSessionDidBecomeActive")
    }

    // [NFCNDEFMessage]가 아닌 NFCTag 배열이 이 함수로 전달된다는 점에 유의하십시오.
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("tagReaderSession")
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
            guard error == nil else {
                session.alertMessage = "에러 발생: \(error!.localizedDescription)"
                session.invalidate()
                return
            }

            print("태그 연결완료")

            switch tag {
            case .miFare(let discoveredTag):
                print("Got a MiFare tag!", discoveredTag.identifier, discoveredTag.mifareFamily)
                print("\(discoveredTag.identifier.base64EncodedString())")
            case .feliCa(let discoveredTag):
                print("Got a FeliCa tag!", discoveredTag.currentSystemCode, discoveredTag.currentIDm)
            case .iso15693(let discoveredTag):
                print("Got a ISO 15693 tag!", discoveredTag.icManufacturerCode, discoveredTag.icSerialNumber, discoveredTag.identifier)
            case .iso7816(let discoveredTag):
                print("Got a ISO 7816 tag!", discoveredTag.initialSelectedAID, discoveredTag.identifier)
            @unknown default:
                session.invalidate(errorMessage: "Unsupported tag!")
            }
        }
    }
}

