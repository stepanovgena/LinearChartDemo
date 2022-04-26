//
//  ChartViewModel.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation

/// Протокол вьюмодели графика
protocol ChartViewModelProtocol {
    var chartDataSetVMs: [ChartDataSetVM] { get set }
}

/// Вьюмодель графика
final class ChartViewModel: ChartViewModelProtocol {
    public var chartDataSetVMs: [ChartDataSetVM]

    init(chartDataSetVMs: [ChartDataSetVM]) {
        self.chartDataSetVMs = chartDataSetVMs
    }
}
