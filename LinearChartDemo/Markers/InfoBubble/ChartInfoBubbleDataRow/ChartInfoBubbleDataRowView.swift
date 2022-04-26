//
//  ChartInfoBubbleDataRowView.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import UIKit

/// Константы, используемые в файле
private enum Constants {
    static var legendSize: CGFloat { 12 }
    static var legendOffset: CGFloat { 12 }
}

/// Цветной индикатор с подписью
final class ChartInfoBubbleDataRowView: UIView {
    private let label = UILabel()
    private let legend = UIImageView()

    var viewModel: ChartInfoBubbleDataRowViewModelProtocol? {
        didSet {
            guard let viewModel = viewModel else { return }
            label.text = viewModel.value
            label.textColor = .white
            legend.tintColor = viewModel.colorAsset.color
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

private extension ChartInfoBubbleDataRowView {
    func commonInit() {
        legend.image = UIImage(systemName: "circle.fill")
        addSubview(legend)
        addSubview(label)

        legend.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.height.equalTo(Constants.legendSize)
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(legend.snp.trailing).offset(Constants.legendOffset)
            $0.centerY.equalTo(legend)
        }

        snp.makeConstraints {
            $0.trailing.equalTo(label)
        }
    }
}
