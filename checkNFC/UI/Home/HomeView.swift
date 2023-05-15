//
//  SummeryViewContainer.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/28.
//

import SwiftUI

struct HomeView: View {

    @State private var showDashboard = false

    @EnvironmentObject private var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                VStack(spacing: 8) {
                    Text("Ive 님의 오늘 기록")
                        .font(.system(size: 24, weight: .bold))

                    Text("2023년 3월 28일 (화)")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding()

                NavigationLink {
                    HomeDetailView()
                } label: {
                    timeDashboard
                }
                .sheet(isPresented: $showDashboard, content: {
                    HomeDetailView()
                })
                .padding()

                Text("이번주에는 평균 00시간 근무했어요 💦")
                    .foregroundColor(.secondary)

                Divider()
                    .padding()

                checkModelList

                Spacer()

                NFCReadButton {
                    
                }
                    .frame(height: 50)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("초기화") {
                        viewModel.resetUserSession()
                    }
                }
            }

        }
    }

    var timeDashboard: some View {
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
        .foregroundColor(.init(uiColor: .label))
    }

    var checkModelList: some View {
        VStack {
            let session = viewModel.getUserData()
            Text("ID: \(session?.id ?? "")")
            Text("이름: \(session?.name ?? "")")
            Text("TagID: \(session?.nfcInfo?.tagID ?? "")")
            Text("업무시간: \(session?.workInfo.workingTime ?? 0.0)")
            Text("점심시간: \(session?.workInfo.lunchTime ?? 0.0)")
        }
    }
}

