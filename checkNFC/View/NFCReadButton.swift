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
