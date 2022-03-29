//
//  CustomButton.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import Foundation
import UIKit

class ThemeableButton: UIButton, Themeable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, font: UIFont = .button, insets: UIEdgeInsets = .default) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = font
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentEdgeInsets = insets
        
        onThemeChanged()
    }
    
    func onThemeChanged() {
        backgroundColor = Theme.current.primary
        setTitleColor(Theme.current.background, for: .normal)
    }
}
