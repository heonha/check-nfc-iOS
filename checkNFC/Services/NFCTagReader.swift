//
//  NFCTagReader.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import CoreNFC

protocol NFCTagReaderDelegate {
    func settedTag(_ tag: NFCTagInfo)
}

final class NFCTagReader: NSObject, NFCTagReaderSessionDelegate {

    var delegate: NFCTagReaderDelegate?

    func scan() {
        let session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
        session?.begin()
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {

        print("tagReaderSession")
    }

    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("tagReaderSessionDidBecomeActive")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("tagReaderSession")

        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "2개 이상의 태그가 접촉되었습니다. 다시 시도해주세요."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }

        if let tag = tags.first {
            session.connect(to: tag) { error in
                if let error = error {
                    session.alertMessage = "에러 발생: \(error.localizedDescription)"
                    session.invalidate()
                    return
                }

                self.checkNFCType(tag) { result in
                    switch result {
                    case .success(let tagInfo):
                        print(tagInfo)

                        self.delegate?.settedTag(tagInfo)

                        session.alertMessage = "연결 성공!"
                        session.invalidate()
                    case .failure(let error):
                        session.invalidate(errorMessage: error.localizedDescription)
                    }
                }
            }
        } else {
            return
        }

    }

    func checkNFCType(_ nfcTag: NFCTag, completion: (Result<NFCTagInfo, NFCReadError>) -> ()) {

        switch nfcTag {
        case .miFare(let discoveredTag):
            let tagID = discoveredTag.identifier.base64EncodedString()
            completion(.success(NFCTagInfo(tagID: tagID, tagType: .MiFare)))

        case .feliCa(let discoveredTag):
            let tagID = discoveredTag.currentSystemCode.base64EncodedString()
            completion(.success(NFCTagInfo(tagID: tagID, tagType: .FeliCa)))

        case .iso15693(let discoveredTag):
            let tagID = discoveredTag.icSerialNumber.base64EncodedString()
            completion(.success(NFCTagInfo(tagID: tagID, tagType: .iso15693)))

        case .iso7816(let discoveredTag):
            print("Got a ISO 7816 tag!", discoveredTag.initialSelectedAID, discoveredTag.identifier)
            let tagID = discoveredTag.initialSelectedAID
            completion(.success(NFCTagInfo(tagID: tagID, tagType: .iso7816)))

        @unknown default:
            completion(.failure(.unknownNFC))
        }
    }

}

enum NFCReadError: Error {
    case unknownNFC
}

enum NFCTagType: Codable {
    case MiFare
    case FeliCa
    case iso15693
    case iso7816
}
