//
//  SummeryViewContainer.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/28.
//

import SwiftUI
import SwiftNFC

struct SummeryViewContainer: View {


    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Ive님의 오늘 기록")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }
                .padding()

                HStack(spacing: 8) {
                    Spacer()

                    VStack(spacing: 8) {
                        Text("출근시간")
                            .font(.system(size: 20, weight: .bold))
                        Text("AM10:00")
                            .font(.system(size: 24, weight: .medium))

                    }
                    Spacer()


                    VStack(spacing: 8) {
                        Text("퇴근시간")
                            .font(.system(size: 20, weight: .bold))

                        Text("PM 7:00")
                            .font(.system(size: 24, weight: .medium))
                    }
                    Spacer()

                }
                .padding()


                Divider()
                    .padding()

                Group {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("최근 출퇴근 현황")
                                .font(.system(size: 24, weight: .bold))
                            Text("이번주에는 평균 00시간 근무했어요 💦")
                                .foregroundColor(.secondary)
                        }
                        ScrollView {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.gray)
                                    .frame(height: 200)
                                Text("리스트")
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.gray)
                                    .frame(height: 200)
                                Text("그래프")
                            }
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                NFCReadButton()
                .frame(height: 50)
                .padding()
                .navigationTitle("2023년 3월 28일 (화)")
                .navigationBarTitleDisplayMode(.inline)
            }

        }
    }
}

struct SummeryViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        SummeryViewContainer()
    }
}
