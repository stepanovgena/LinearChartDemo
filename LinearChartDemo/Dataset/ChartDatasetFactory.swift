//
//  ChartDatasetFactory.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import UIKit
import Charts

/// Фабрика подготовки датасета для графика
struct ChartDatasetFactory {
    func makeChartDataset(
        colorAsset: DataColor,
        entries: [ChartDataEntry]
    ) -> LineChartDataSet {
        var dataSet = LineChartDataSet(entries: entries, label: nil)

        // общие настройки графика
        dataSet.setColor(colorAsset.color)
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier // сглаживание
        dataSet.drawValuesEnabled = false // убираем значения на графике
        dataSet.drawCirclesEnabled = false // убираем точки на графике
        dataSet.drawFilledEnabled = true // нужно для градиента

        // оформление, связанное с выбором значения на графике
        dataSet.drawHorizontalHighlightIndicatorEnabled = false // оставляем только вертикальную линию
        dataSet.highlightLineWidth = 2 // толщина вертикальной линии
        dataSet.highlightColor = colorAsset.color // цвет вертикальной линии

        addGradient(to: &dataSet, colorAsset: colorAsset)

        return dataSet
    }
}

private extension ChartDatasetFactory {
    func addGradient(
        to dataSet: inout LineChartDataSet,
        colorAsset: DataColor
    ) {
        let mainColor = colorAsset.color.withAlphaComponent(0.5)
        let secondaryColor = colorAsset.color.withAlphaComponent(0)
        let colors = [
            mainColor.cgColor,
            secondaryColor.cgColor,
            secondaryColor.cgColor
        ] as CFArray
        let locations: [CGFloat] = [0, 0.79, 1]
        if let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors,
            locations: locations
        ) {
            dataSet.fill = .fillWithLinearGradient(gradient, angle: 270)
        }
    }
}
