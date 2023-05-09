//
//  NFCReadButton.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI
import CoreNFC

struct NFCReadButton: View {

    enum StackAxis {
        case horizontal
        case vertical
    }
    
    var axis: StackAxis = .horizontal

    var action: () -> ()

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue)

                switch axis {
                case .horizontal:
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
                case .vertical:
                    VStack {
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

}
