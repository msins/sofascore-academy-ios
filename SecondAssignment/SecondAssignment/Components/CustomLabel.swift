//
//  CustomLabel.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        self.font = font
        self.textColor = .primaryText
    }
}
