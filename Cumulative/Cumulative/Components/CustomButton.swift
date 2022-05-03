//
//  CustomButton.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, color: UIColor = .primary, insets: UIEdgeInsets = .default) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentEdgeInsets = insets
        
        backgroundColor = color
        setTitleColor(.background, for: .normal)
    }
}
