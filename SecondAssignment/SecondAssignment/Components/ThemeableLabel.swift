//
//  CustomLabel.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import Foundation
import UIKit

class ThemeableLabel: UILabel, Themeable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, font: UIFont = .title) {
        super.init(frame: .zero)
        
        self.text = text
        self.font = font
    }
    
    func onThemeChanged() {
        self.textColor = Theme.current.primaryText
    }
}
