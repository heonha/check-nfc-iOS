//
//  RegistNameView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistNameView: View {

    @EnvironmentObject var viewModel: RegistViewModel
    @StateObject var coordinator = Coordinator<RegistDestination>(destination: .none)

    @State var isSetName = false

    var body: some View {
        ZStack {
            coordinator.navigationLinkSection()
            VStack(spacing: 16) {

                Spacer()

                Text("앱에서 사용할 이름을 입력하세요.")
                    .font(.system(size: 20, weight: .medium))
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.init(uiColor: .secondarySystemFill))
                    TextField("메인화면에 보여질 이름", text: $viewModel.name)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .textCase(.none)
                        .padding(4)
                }
                .frame(height: 50)

                Spacer()

                Button {
                    if viewModel.name.isEmpty {
                        isSetName = true
                    } else {
                        coordinator.push(destination: .time)
                    }
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
                .alert("이름 확인", isPresented: $isSetName) {
                    Button("확인") {
                        return
                    }
                } message: {
                    Text("앱에서 사용할 이름을 입력해주세요.")
                }

            }
            .padding()
        }


    }
}

struct RegistNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistNameView()
                .environmentObject(RegistViewModel())
        }
    }
}
