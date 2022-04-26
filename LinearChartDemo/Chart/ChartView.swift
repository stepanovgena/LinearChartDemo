//
//  ChartView.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 11.04.2022.
//

import UIKit
import SnapKit
import Charts

/// Константы, используемые в файле
private enum Constants {
    static var chartBottomInset: CGFloat { 40 }
    static var infoBubbleMargin: CGFloat { 12 }
}

/// Вьюшка графика
final class ChartView: UIView {
    private let chart = LineChartView()
    private let circleMarker = CircleMarker()
    private let infoBubble = ChartInfoBubbleView()

    var viewModel: ChartViewModelProtocol? {
        didSet {
            updateChartDatasets()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - ChartViewDelegate
extension ChartView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let viewModel = viewModel else { return }
        // Показываем инфо баблик в нужном месте
        let infoBubbleVmFactory = ChartInfoBubbleVmFactory(
            entry: entry,
            chartDatasetVMs: viewModel.chartDataSetVMs
        )
        infoBubble.viewModel = infoBubbleVmFactory.makeInfoBubbleVM()

        let markerPosition = CGPoint(x: highlight.xPx, y: highlight.yPx)
        let offsetProvider = InfoBubbleOffsetProvider()
        let fittingOffset = offsetProvider.getFittingOffset(
            forChild: infoBubble,
            inParent: chartView,
            withMarker: markerPosition,
            margin: Constants.infoBubbleMargin
        )

        infoBubble.snp.updateConstraints {
            $0.centerX.equalToSuperview().offset(fittingOffset.x)
            $0.centerY.equalToSuperview().offset(fittingOffset.y)
        }

        infoBubble.isHidden = false
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        infoBubble.isHidden = true
    }
}

// MARK: - Private methods
private extension ChartView {
    func commonInit() {
        setupChartView()
        setupInfoBubble()
    }

    func setupChartView() {
        addSubview(chart)
        chart.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.chartBottomInset).priority(.medium)
        }
        chart.isUserInteractionEnabled = true

        // отключаем координатную сетку
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.drawGridBackgroundEnabled = false
        // отключаем подписи к осям
        chart.xAxis.drawLabelsEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        // отключаем легенду
        chart.legend.enabled = false
        // отключаем зум
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        // убираем артефакты вокруг области графика
        chart.xAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.drawBordersEnabled = false
        chart.minOffset = 0
        // устанавливаем делегата, нужно для обработки нажатий
        chart.delegate = self

        // маркеры
        chart.drawMarkers = true
        circleMarker.chartView = chart
        chart.marker = circleMarker
    }

    func setupInfoBubble() {
        chart.addSubview(infoBubble)
        infoBubble.isHidden = true
        infoBubble.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    func updateChartDatasets() {
        guard let viewModel = viewModel else { return }
        let chartData = LineChartData()
        let dataSetFactory = ChartDatasetFactory()
        viewModel.chartDataSetVMs.forEach {
            let dataSet = dataSetFactory.makeChartDataset(
                colorAsset: $0.colorAsset,
                entries: $0.chartDataEntries
            )
            chartData.addDataSet(dataSet)
        }
        chart.data = chartData
    }
}
