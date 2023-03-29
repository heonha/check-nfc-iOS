//
//  NFCReadButton.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import CoreNFC

struct NFCReadButton: View {

    @State var urlT = ""
    @State var reader = NFCTagReader()

    var body: some View {
        Button {
            reader.scan()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue)
                HStack {
                    Image("NFC")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .colorInvert()
                    Text("NFC 태그")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }

            }
        }
    }
}

struct NFCReadButton_Previews: PreviewProvider {
    static var previews: some View {
        NFCReadButton()
    }
}

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
                    session.alertMessage = "에러발생: \(error?.localizedDescription)"
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




