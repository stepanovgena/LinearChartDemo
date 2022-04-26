//
//  InfoBubbleViewModel.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation

/// Протокол вью-модели информационного маркера графика
protocol ChartInfoBubbleViewModelProtocol {
    var title: String { get set }
    var dataSet: [ChartInfoBubbleDataRowViewModelProtocol] { get set }
}

/// Вью-модель информационного маркера графика
final class ChartInfoBubbleViewModel: ChartInfoBubbleViewModelProtocol {
    var title: String
    var dataSet: [ChartInfoBubbleDataRowViewModelProtocol]

    init(
        title: String,
        dataSet: [ChartInfoBubbleDataRowViewModelProtocol]
    ) {
        self.title = title
        self.dataSet = dataSet
    }
}
