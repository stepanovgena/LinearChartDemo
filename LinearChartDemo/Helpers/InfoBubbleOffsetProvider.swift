//
//  InfoBubbleOffsetProvider.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import UIKit

/// Оффсет между центрами баблика и чарта
struct InfoBubbleOffset {
    let x: CGFloat
    let y: CGFloat
}

/// Рассчитывает оптимальный оффсет между центрами вьюшек
struct InfoBubbleOffsetProvider {
    func getFittingOffset(
        forChild view: UIView,
        inParent parent: UIView,
        withMarker markerPosition: CGPoint,
        margin: CGFloat
    ) -> InfoBubbleOffset {
        let labelSize = view.bounds.size

        var preferredLabelCenterX = max(markerPosition.x - labelSize.width / 2 - margin, 0)
        var preferredLabelCenterY = min(markerPosition.y + labelSize.height / 2 + margin, parent.bounds.height)

        let fitsLeftBorder = preferredLabelCenterX - labelSize.width / 2 >= 0
        let fitsBottom = parent.bounds.height - preferredLabelCenterY - labelSize.height >= 0

        if !fitsLeftBorder {
            preferredLabelCenterX = markerPosition.x + labelSize.width / 2 + margin
        }

        if !fitsBottom {
            preferredLabelCenterY = markerPosition.y - labelSize.height / 2 - margin
        }

        let chartCenterX = parent.bounds.width / 2
        let chartCenterY = parent.bounds.height / 2

        let offsetX = preferredLabelCenterX - chartCenterX
        let offsetY = preferredLabelCenterY - chartCenterY

        return InfoBubbleOffset(x: offsetX, y: offsetY)
    }
}
