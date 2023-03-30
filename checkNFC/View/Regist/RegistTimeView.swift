//
//  RegistTimeView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistTimeView: View {

    @StateObject var viewModel: OnboardingViewModel

    var body: some View {
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

            CircularClockViewPresenter(viewModel: viewModel)

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
//
//struct RegistTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistTimeView()
//    }
//}
