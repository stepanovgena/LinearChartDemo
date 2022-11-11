//
//  ChartDatasetFactory.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import UIKit
import Charts

/// Factory preparing dataset for a single chart
struct ChartDatasetFactory {
    func makeChartDataset(
        colorAsset: DataColor,
        entries: [ChartDataEntry]
    ) -> LineChartDataSet {
        var dataSet = LineChartDataSet(entries: entries, label: "")

        // chart main settings
        dataSet.setColor(colorAsset.color)
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier // curve smoothing
        dataSet.drawValuesEnabled = false // disble values
        dataSet.drawCirclesEnabled = false // disable circles
        dataSet.drawFilledEnabled = true // gradient setting

        // settings for picking values on graph
        dataSet.drawHorizontalHighlightIndicatorEnabled = false // leave only vertical line
        dataSet.highlightLineWidth = 2 // vertical line width
        dataSet.highlightColor = colorAsset.color // vertical line color

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
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 270)
        }
    }
}
