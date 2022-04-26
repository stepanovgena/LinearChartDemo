//
//  ChartInfoBubbleDataRowConverter.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation

/// Константы, используемые в файле
private enum Constants {
    static var rubSymbol: String { " ₽" }
}

/// Преобразует данные точки из оригинального набора в данные для представления в баблике маркера
struct ChartInfoBubbleDataRowConverter {
    func convert(dataSetVMs: [ChartDataSetVM], position: Int) -> [ChartInfoBubbleDataRowViewModel] {
        return dataSetVMs.map {
            let color = $0.colorAsset
            guard position <= $0.chartDataEntries.count else { return .init(colorAsset: color, value: "") }
            let dataEntry = $0.chartDataEntries[position - 1].y
            let formattedValue = String(dataEntry) + Constants.rubSymbol
            return ChartInfoBubbleDataRowViewModel(colorAsset: color, value: formattedValue)
        }
    }
}
