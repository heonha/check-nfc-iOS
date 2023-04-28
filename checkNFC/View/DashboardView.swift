//
//  SummeryViewContainer.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/28.
//

import SwiftUI

struct DashboardView: View {

    @State var showDashboard = false

    @EnvironmentObject var viewModel: HomeViewModel
    @ObservedObject var authService = UserAuthService.shared

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
                    DetailDashboardView()
                } label: {
                    timeDashboard
                }
                .sheet(isPresented: $showDashboard, content: {
                    DetailDashboardView()
                })
                .padding()

                Text("이번주에는 평균 00시간 근무했어요 💦")
                    .foregroundColor(.secondary)

                Divider()
                    .padding()

                Spacer()

                NFCReadButton(viewModel: viewModel) {
                    
                }
                    .frame(height: 50)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("초기화") {
                        authService.user = nil
                        UserDefaults.standard.set(nil, forKey: "user")
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
}

