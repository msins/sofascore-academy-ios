//
//  CustomTableCell.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 05.04.2022..
//

import UIKit
import SnapKit

class MessageTableViewCell: UITableViewCell {
    
    var messageLabel = CustomLabel()
    var backgroundCard = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .background
        selectionStyle = .none
        
        configureBackgroundCard()
        configureMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(message: Message, isSelected: Bool) {
        messageLabel.text = message.text
        isSelected ? select() : deselect()
    }
    
    func configureBackgroundCard() {
        backgroundView = backgroundCard
        
        backgroundCard.backgroundColor = .background
        backgroundCard.layer.cornerRadius = 8
        backgroundCard.layer.borderWidth = 1.5
        backgroundCard.layer.borderColor = UIColor.primary.cgColor
        
        backgroundCard.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView.layoutMarginsGuide)
            $0.width.height.equalTo(contentView.layoutMarginsGuide)
        }
    }
    
    func configureMessageLabel() {
        contentView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints {
            $0.centerY.centerX.equalTo(backgroundCard.layoutMarginsGuide)
        }
        
        messageLabel.numberOfLines = 0
        messageLabel.adjustsFontSizeToFitWidth = true
    }
    
    func select() {
        isSelected = true
        backgroundView?.backgroundColor = .primary
    }
    
    func deselect() {
        isSelected = false
        backgroundView?.backgroundColor = .background
    }
}
