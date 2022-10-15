//
//  ChartDatasetVM.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation
import Charts

/// Single chart data model
struct ChartDataSetVM {
    public let colorAsset: DataColor
    public let chartDataEntries: [ChartDataEntry]

    init(
        colorAsset: DataColor,
        chartDataEntries: [ChartDataEntry]
    ) {
        self.colorAsset = colorAsset
        self.chartDataEntries = chartDataEntries
    }
}
