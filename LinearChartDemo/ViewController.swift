//
//  ViewController.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 11.04.2022.
//

import UIKit
import SnapKit
import Charts

/// Константы, используемые в файле
private enum Constants {
    static var horizontalInset: CGFloat { 24 }
    static var chartHeight: CGFloat { 300 }
}

class ViewController: UIViewController {
    private let chartView = ChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChartView()
    }
}

private extension ViewController {
    func setupChartView() {
        view.addSubview(chartView)
        chartView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalInset)
            $0.height.equalTo(Constants.chartHeight)
        }

        let chartDataSetOne = ChartDataSetVM(
            colorAsset: .first,
            chartDataEntries: makeRandomChartDataset()
        )
        // раскомментируйте ниже, чтобы попробовать двойной график
//        let chartDataSetTwo = ChartDataSetVM(
//            colorAsset: .second,
//            chartDataEntries: makeRandomChartDataset()
//        )
        let chartVM = ChartViewModel(
            chartDataSetVMs: [
                chartDataSetOne,
                // раскомментируйте ниже, чтобы попробовать двойной график
//                chartDataSetTwo,
            ]
        )
        chartView.viewModel = chartVM
    }

    ///  Готовит случайный набор данных для отображения
    func makeRandomChartDataset() -> [ChartDataEntry] {
        var numbers = [Double]()
        for number in 1...10 {
            numbers.append(Double(number) + Double(number) / 100)
        }

        var entries = [ChartDataEntry]()

        for position in 1...20 {
            if let randomValue = numbers.randomElement() {
                let entry = ChartDataEntry(
                    x: Double(position),
                    y: randomValue,
                    data: "\(position) января 2022")
                entries.append(entry)
            }
        }

        return entries
    }
}

