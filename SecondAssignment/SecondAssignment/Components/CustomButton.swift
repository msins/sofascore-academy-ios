//
//  CustomButton.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, insets: UIEdgeInsets = .default) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentEdgeInsets = insets
        
        backgroundColor = .primary
        setTitleColor(.background, for: .normal)
    }
}
