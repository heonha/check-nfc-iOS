//
//  SummeryViewContainer.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/28.
//

import SwiftUI

struct SummeryViewContainer: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("2023년 3월 28일 (화)")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }
                .padding()

                HStack(spacing: 8) {
                    Spacer()

                    VStack(spacing: 8) {
                        Text("출근시간")
                            .font(.system(size: 24, weight: .bold))
                        Text("AM10:00")
                            .font(.system(size: 20, weight: .medium))

                    }
                    Spacer()


                    VStack(spacing: 8) {
                        Text("퇴근시간")
                            .font(.system(size: 24, weight: .bold))

                        Text("AM10:00")
                            .font(.system(size: 20, weight: .medium))
                    }
                    Spacer()

                }
                .padding()


                Divider()
                    .padding()

                Group {
                    VStack(alignment: .leading) {
                        Text("최근 출퇴근 현황")
                            .font(.system(size: 24, weight: .bold))
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
                .padding()

                Spacer()

                Button {

                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue)
                        HStack {
                            Image("NFC")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            Text("NFC 태그")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        }

                    }
                }
                .frame(height: 50)
                .padding()
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
