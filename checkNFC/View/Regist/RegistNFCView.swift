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
    @ObservedObject var mainViewModel = HomeViewModel.shared

    @State var isSetNFC = false // NFC가 정상 등록 된 경우에만 변경되야함

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("사용할 NFC 등록하기")
                .font(.system(size: 20, weight: .medium))

            NFCReadButton(viewModel: HomeViewModel.shared, axis: .vertical) {
                viewModel.nfcService.registTag()
            }
            .frame(width: 100, height: 100)

            Spacer()


            Button {
                viewModel.registUserWithoutNFC()
            } label: {
                Text("NFC 등록없이 시작하기")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(.bottom)


            Button {
                viewModel.registUserWithNFC()
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
