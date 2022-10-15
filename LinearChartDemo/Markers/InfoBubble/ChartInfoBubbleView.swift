//
//  InfoBubbleView.swift
//  LinearChartDemo
//
//  Created by Gennady Stepanov on 12.04.2022.
//

import UIKit
import SnapKit

/// Constants
private enum Constants {
    static var cornerRadius: CGFloat { 12 }
    static var verticalSpacing: CGFloat { 8 }
    static var horizontalSpacing: CGFloat { 12 }
}

/// Info bubble for selected point
final class ChartInfoBubbleView: UIView {
    private let title = UILabel()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    var viewModel: ChartInfoBubbleViewModelProtocol? {
        didSet {
            guard let viewModel = viewModel else { return }
            title.text = viewModel.title
            title.textColor = .white
            stackView.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
            viewModel.dataSet.forEach {
                let row = ChartInfoBubbleDataRowView()
                row.viewModel = $0
                stackView.addArrangedSubview(row)
            }
        }
    }

    func commonInit() {
        addSubview(title)
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = Constants.verticalSpacing

        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalSpacing)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(Constants.verticalSpacing)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.horizontalSpacing)
        }

        backgroundColor = UIColor.black.withAlphaComponent(0.87)
        layer.cornerRadius = Constants.cornerRadius
    }
}

