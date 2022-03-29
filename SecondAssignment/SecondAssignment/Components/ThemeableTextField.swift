//
//  CustomTextField.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import Foundation
import UIKit

class ThemeableTextField: UITextField, Themeable {
    
    let insets: UIEdgeInsets
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(insets: UIEdgeInsets = .default) {
        self.insets = insets
        super.init(frame: .zero)
        
        layer.borderWidth = 1.0
        layer.cornerRadius = 8
        onThemeChanged()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    func onThemeChanged() {
        layer.borderColor = Theme.current.primary.cgColor
    }
}
