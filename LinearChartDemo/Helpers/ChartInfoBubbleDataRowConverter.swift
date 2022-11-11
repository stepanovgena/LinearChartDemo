//
//  ChartInfoBubbleDataRowConverter.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation

/// Constants
private enum Constants {
    static var currencySymbol: String { " $" }
}

/// Converts original dataset to info bubble representation
struct ChartInfoBubbleDataRowConverter {
    func convert(dataSetVMs: [ChartDataSetVM], position: Int) -> [ChartInfoBubbleDataRowViewModel] {
        return dataSetVMs.map {
            let color = $0.colorAsset
            guard position <= $0.chartDataEntries.count else { return .init(colorAsset: color, value: "") }
            let dataEntry = $0.chartDataEntries[position - 1].y
            let formattedValue = String(dataEntry) + Constants.currencySymbol
            return ChartInfoBubbleDataRowViewModel(colorAsset: color, value: formattedValue)
        }
    }
}
