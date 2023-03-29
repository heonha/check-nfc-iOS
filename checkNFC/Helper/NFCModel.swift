//
//  NFCModel.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import UIKit

import CoreNFC


class NFCViewController: UITableViewController {

    var session: NFCNDEFReaderSession?
    var alertController: UIAlertController = .init()
    var detectedMessages = [NFCNDEFMessage]()
    var message: NFCNDEFMessage = .init(records: [])

    func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support tag scanning.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }

        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "아이폰을 NFC 태그 근처에 두십시오."
        session?.begin()

    }

    /// 태그에 쓰기 위해 샘플 앱은 새 리더 세션을 시작합니다.
    /// 태그에 NDEF 메시지를 쓰려면 이 세션이 활성 상태여야 하므로
    /// 이번에는 invalidateAfterFirstRead가 false로 설정되어 태그를 읽은 후 세션이 유효하지 않게 되는 것을 방지합니다.
    func beginWrite(_ sender: Any) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near an NDEF tag to write the message."
        session?.begin()
    }

}


extension NFCViewController: NFCNDEFReaderSessionDelegate {

    /// 샘플 앱에서 대리자는 단일 태그 리더 세션 중에 첫 번째 태그를 읽거나 사용자가 세션을 취소하는 것 이외의 이유로
    /// 리더 세션이 종료될 때 경고를 표시합니다.
    /// 또한 무효화된 리더 세션을 재사용할 수 없으므로 샘플 앱은 self.session을 nil로 설정합니다.
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // 반환된 오류에서 무효화 사유를 확인합니다.
        if let readerError = error as? NFCReaderError {
            // 무효화 사유가
            // 단일 태그 읽기 세션 동안 또는
            // 사용자가 UI에서 다중 태그 읽기 세션을 취소했거나
            // 프로그래밍 방식으로 무효화 메서드 호출을 사용합니다.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                    title: "세션이 무효화되었습니다.",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        // 새 태그를 읽으려면 새 세션 인스턴스가 필요합니다.
        self.session = nil
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            // 감지된 NFCNDEFMessage 개체를 처리합니다.
            self.detectedMessages.append(contentsOf: messages)
            self.tableView.reloadData()
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            // Restart polling in 500 milliseconds.
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than 1 tag is detected. Please remove all tags and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }

        // Connect to the found tag and write an NDEF message to it.
        let tag = tags.first!
        session.connect(to: tag, completionHandler: { (error: Error?) in
            if nil != error {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                return
            }

            tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                guard error == nil else {
                    session.alertMessage = "Unable to query the NDEF status of tag."
                    session.invalidate()
                    return
                }

                switch ndefStatus {
                case .notSupported:
                    session.alertMessage = "Tag is not NDEF compliant."
                    session.invalidate()
                case .readOnly:
                    session.alertMessage = "Tag is read only."
                    session.invalidate()
                case .readWrite:
                    tag.writeNDEF(self.message, completionHandler: { (error: Error?) in
                        if nil != error {
                            session.alertMessage = "Write NDEF message fail: \(error!)"
                        } else {
                            session.alertMessage = "Write NDEF message successful."
                        }
                        session.invalidate()
                    })
                @unknown default:
                    session.alertMessage = "Unknown NDEF tag status."
                    session.invalidate()
                }
            })
        })
    }
}
