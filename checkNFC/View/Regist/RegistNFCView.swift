//
//  RegistNFCView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistNFCView: View {

    @EnvironmentObject var viewModel: RegistViewModel
    @StateObject var coordinator = Coordinator<RegistDestination>(destination: .none)
    @ObservedObject var mainViewModel = MainViewModel.shared

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("사용할 NFC 등록하기")
                .font(.system(size: 20, weight: .medium))
            NFCReadButton(viewModel: MainViewModel.shared, axis: .vertical)
                .frame(width: 100, height: 100)


            Spacer()

            switch viewModel.nfcID.isEmpty {
            case true:
                Button {

                } label: {
                    Text("NFC 등록없이 시작하기")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
            case false:
                Text("NFC 태그 등록완료")
                    .foregroundColor(.green)
                    .font(.system(size: 20, weight: .bold))
                Text("아래 완료버튼을 눌러 시작하세요.")
            }



            Button {
                mainViewModel.userID = UUID().uuidString
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.init(uiColor: .systemBlue))
                    Text("완료")
                        .foregroundColor(.init(uiColor: .systemBackground))
                        .font(.system(size: 18, weight: .medium))

                }
            }
            .frame(height: 40)

        }
        .padding()
    }
}

struct RegistNFCView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistNFCView()
                .environmentObject(RegistViewModel())
        }
    }
}
