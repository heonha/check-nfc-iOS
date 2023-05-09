//
//  WelcomeView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistWelcomeView: View {

    @EnvironmentObject private var viewModel: RegistViewModel
    @StateObject private var coordinator = Coordinator<RegistDestination>(destination: .none)

    var body: some View {
        ZStack {
            coordinator.navigationLinkSection()
            VStack(spacing: 16) {
                Spacer()

                Text("NFC 출근체크앱을 시작합니다.")

                Text("출근체크를 위해서 몇가지 준비해볼까요?💪")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.bottom)

                Spacer()

                Button {
                    coordinator.push(destination: .name)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.init(uiColor: .systemBlue))
                        Text("다음")
                            .foregroundColor(.init(uiColor: .systemBackground))
                            .font(.system(size: 18, weight: .medium))

                    }
                }
                .frame(height: 40)
            }
            .padding()
        }
    }

}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistWelcomeView()
                .environmentObject(RegistViewModel())
        }
    }
}
