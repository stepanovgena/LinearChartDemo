//
//  InfoBubbleViewModel.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import Foundation

/// Info bubble VM protocol
protocol ChartInfoBubbleViewModelProtocol {
    var title: String { get set }
    var dataSet: [ChartInfoBubbleDataRowViewModelProtocol] { get set }
}

/// Info bubble VM
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
