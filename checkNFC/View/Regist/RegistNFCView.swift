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

    @State var showSetNFCAlert = false

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("사용할 NFC 등록하기")
                .font(.system(size: 20, weight: .medium))

            NFCReadButton(viewModel: HomeViewModel.shared, axis: .vertical) {
                viewModel.registTag()
            }
            .frame(width: 100, height: 100)

            Spacer()

            Button {
                viewModel.registUser(withTag: .none)
            } label: {
                Text("NFC태그가 없으신가요? ")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                + Text("NFC없이 시작하기")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.bottom)

            Button {
                if viewModel.tagInfo == .none {
                    self.showSetNFCAlert.toggle()
                } else {
                    viewModel.registUser(withTag: .nfcTag)
                }
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
            .alert("NFC 확인", isPresented: $showSetNFCAlert) {
                Button {
                    viewModel.registUser(withTag: .none)
                } label: {
                    Text("등록없이 시작하기")
                }

                Button {
                    viewModel.registTag()
                } label: {
                    Text("NFC 등록하기")
                }


            } message: {
                Text("NFC Tag가 등록되지 않았어요, NFC 없이 시작할까요?")
            }

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
