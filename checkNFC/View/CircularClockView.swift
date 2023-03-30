//
//  CircularClockView.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/03/30.
//

import UIKit
import SwiftUI
import HGCircularSlider
import SnapKit
import Combine

class CircularClockView<V: CircularClockViewProtocol>: UIView {
    var rangeCircularSlider = RangeCircularSlider()
    var clockFormatSegmentedControl = UISegmentedControl()
    @ObservedObject var viewModel: V

    var hoursImageView: UIImageView = {
        let image = UIImage(named: "time_indicators")
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()

    var durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8:00"
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.textColor = .systemBackground
        return label
    }()


    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()

    init(viewModel: V, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        superViewSetup()
        sliderSetup()
        subviewSetup()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func superViewSetup() {
        backgroundColor = .systemBackground
    }

    func sliderSetup() {

        rangeCircularSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeCircularSlider.addTarget(self, action: #selector(updateTexts), for: .allTouchEvents)

        addSubview(rangeCircularSlider)

        rangeCircularSlider.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.height.equalTo(320)
        }
        // Slider
        rangeCircularSlider.trackFillColor = .systemBlue
        rangeCircularSlider.lineWidth = 40
        rangeCircularSlider.diskColor = .black
        rangeCircularSlider.diskFillColor = .darkGray
        rangeCircularSlider.trackColor = .black
        rangeCircularSlider.backtrackLineWidth = 40
        rangeCircularSlider.numberOfRounds = 2
        rangeCircularSlider.backgroundColor = .clear

        rangeCircularSlider.startThumbImage = UIImage(named: "gotohome")
        rangeCircularSlider.endThumbImage = UIImage(named: "gotowork")
    }


    func subviewSetup() {

        // ImageView
        rangeCircularSlider.addSubview(hoursImageView)
        hoursImageView.snp.makeConstraints { make in
            make.center.equalTo(rangeCircularSlider)
            make.width.height.equalTo(190)
        }

        // 중앙 시간 라벨
        rangeCircularSlider.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.center.equalTo(rangeCircularSlider)
        }

        let dayInSeconds = 24 * 60 * 60
        rangeCircularSlider.maximumValue = CGFloat(dayInSeconds)

        rangeCircularSlider.startPointValue = 1 * 60 * 60
        rangeCircularSlider.endPointValue = 8 * 60 * 60

        updateTexts(rangeCircularSlider)
    }

    @objc func updateTexts(_ sender: AnyObject) {
        adjustValue(value: &rangeCircularSlider.startPointValue)
        adjustValue(value: &rangeCircularSlider.endPointValue)

        let startTime = TimeInterval(rangeCircularSlider.startPointValue)
        let startDate = Date(timeIntervalSinceReferenceDate: startTime)
        DispatchQueue.main.async {
            self.viewModel.startWorkTime = self.dateFormatter.string(from: startDate)
        }

        let endTime = TimeInterval(rangeCircularSlider.endPointValue)
        let endDate = Date(timeIntervalSinceReferenceDate: endTime)
        DispatchQueue.main.async {
            self.viewModel.endWorkTime = self.dateFormatter.string(from: endDate)
        }

        let duration = endTime - startTime
        let durationDate = Date(timeIntervalSinceReferenceDate: duration)
        dateFormatter.dateFormat = "H:mm"

        DispatchQueue.main.async {
            self.durationLabel.text = self.dateFormatter.string(from: durationDate)
        }
//        dateFormatter.dateFormat = "hh:mm a"
    }

    func adjustValue(value: inout CGFloat) {
        let minutes = value / 60
        let adjustedMinutes =  ceil(minutes / 5.0) * 5
        value = adjustedMinutes * 60
    }

}

struct CircularClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
//            CircularSliderViewPresenter()
        }
    }
}

protocol CircularClockViewProtocol: ObservableObject {
    var startWorkTime: String {get set}
    var endWorkTime: String {get set}

}
