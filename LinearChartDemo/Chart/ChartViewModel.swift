//
//  ChartViewModel.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation

/// View model protocol
protocol ChartViewModelProtocol {
    var chartDataSetVMs: [ChartDataSetVM] { get set }
}

/// View model
final class ChartViewModel: ChartViewModelProtocol {
    public var chartDataSetVMs: [ChartDataSetVM]

    init(chartDataSetVMs: [ChartDataSetVM]) {
        self.chartDataSetVMs = chartDataSetVMs
    }
}
