//
//  RegistTimeView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct RegistTimeView: View {
    
    @EnvironmentObject var viewModel: RegistViewModel
    @StateObject var coordinator = Coordinator<RegistDestination>(destination: .none)

    @State var workingTime: CGFloat = 8.0
    @State var lunchTime: CGFloat = 1.0

    var body: some View {
        
        ZStack {
            coordinator.navigationLinkSection()
            VStack(spacing: 16) {
                
                Spacer()
                
                Text("하루에 몇시간 근무하세요?")
                    .font(.system(size: 20, weight: .medium))
                
                HStack {
                    Text("근무시간")
                        .font(.system(size: 22, weight: .medium))
                    Button {
                        workingTime -= 0.5
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
                    
                    Text(String(format: "%.1f", workingTime))
                        .font(.system(size: 22, weight: .bold))
                    + Text("시간")
                        .font(.system(size: 20, weight: .medium))
                    
                    Button {
                        workingTime += 0.5
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
                        lunchTime -= 0.5
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
                    
                    
                    Text(String(format: "%.1f", lunchTime))
                        .font(.system(size: 22, weight: .bold))
                    
                    + Text("시간")
                        .font(.system(size: 20, weight: .medium))
                    
                    
                    Button {
                        lunchTime += 0.5
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
                
                Spacer()

                Button {
                    viewModel.setWorkInfo(workingTime: workingTime, lunchTime: lunchTime)
                    coordinator.push(destination: .nfc)
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

struct RegistTimeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistTimeView()
                .environmentObject(RegistViewModel())
        }
    }
}
