//
//  UIViewRepresenter.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import SwiftUI

struct CircularClockViewPresenter<V: CircularClockViewProtocol>: UIViewRepresentable {

    @ObservedObject var viewModel: V

    func makeUIView(context: Context) -> UIView {
        let circularClockView = CircularClockView(viewModel: viewModel, frame: .zero)
        return circularClockView
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

    typealias UIViewType = UIView
}


//
//struct CircularSliderViewPresenter_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            CircularSliderViewPresenter()
//        }
//    }
//}
