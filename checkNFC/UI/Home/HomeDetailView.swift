//
//  HomeDetailView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/29.
//

import SwiftUI

struct HomeDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("최근 출퇴근 현황")
                    .font(.system(size: 24, weight: .bold))
                Text("이번주에는 평균 00시간 근무했어요 💦")
                    .foregroundColor(.secondary)

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
    }
}

struct CheckDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView()
    }
}
