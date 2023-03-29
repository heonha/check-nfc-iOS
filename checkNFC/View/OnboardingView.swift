//
//  OnboardingView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject var viewModel = OnboardingViewModel()

    var body: some View {
        NavigationView {
            firstView
        }
    }

    var firstView: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("NFC 출근체크앱을 시작합니다.")
            Text("출근체크를 위해서 몇가지 준비해볼까요?💪")
                .font(.system(size: 18, weight: .medium))
                .padding(.bottom)

            Spacer()
            NavigationLink {
                nameView
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

    var nameView: some View {
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

            NavigationLink {
                workingTimeView
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

    var workingTimeView: some View {
        VStack(spacing: 16) {

            Spacer()

            Text("하루에 몇시간 근무하세요?")
                .font(.system(size: 20, weight: .medium))

            HStack {
                Text("근무시간")
                    .font(.system(size: 22, weight: .medium))
                Button {
                    viewModel.workingTime -= 0.5
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                        Image(systemName: "minus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 30)

                Text(String(format: "%.1f", viewModel.workingTime))
                    .font(.system(size: 22, weight: .bold))
                + Text("시간")
                    .font(.system(size: 20, weight: .medium))

                Button {
                    viewModel.workingTime += 0.5
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 30)
            }
            .frame(height: 50)




            HStack {

                Text("점심시간")
                    .font(.system(size: 22, weight: .medium))

                Button {
                    viewModel.lunchTime -= 0.5
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                        Image(systemName: "minus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)

                    }
                }
                .frame(height: 30)


                Text(String(format: "%.1f", viewModel.lunchTime))
                    .font(.system(size: 22, weight: .bold))

                + Text("시간")
                    .font(.system(size: 20, weight: .medium))


                Button {
                    viewModel.lunchTime += 0.5
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 30)

            }
            .frame(height: 50)



            Spacer()

            NavigationLink {
                nfcView
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

    var nfcView: some View {
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
                MainViewModel.shared.userID = UUID().uuidString
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

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}



#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
