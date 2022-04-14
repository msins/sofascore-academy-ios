//
// Created by Marko Sinkovic on 09.04.2022..
//

import UIKit
import SnapKit

class ProfileInformationTableCell: UITableViewCell {

    private let keyLabel = CustomLabel()
    private let valueLabel = CustomLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .background
        selectionStyle = .none

        configureKeyLabel()
        configureValueLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }

    // MARK: views

    private func configureKeyLabel() {
        contentView.addSubview(keyLabel)

        keyLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.layoutMarginsGuide)
            $0.leading.equalTo(contentView.layoutMarginsGuide)
        }
    }

    private func configureValueLabel() {
        contentView.addSubview(valueLabel)

        valueLabel.snp.makeConstraints {
            $0.centerY.equalTo(keyLabel.snp.centerY)
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
        }
    }
}

