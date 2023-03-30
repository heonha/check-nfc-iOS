//
//  RegistNameView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistNameView: View {

    @StateObject var viewModel: OnboardingViewModel

    var body: some View {
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

//struct RegistNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistNameView()
//    }
//}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
