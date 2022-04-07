//
//  CustomTextField.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit

class CustomTextField: UITextField {
    
    let insets: UIEdgeInsets
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(insets: UIEdgeInsets = .default) {
        self.insets = insets
        super.init(frame: .zero)
        
        layer.borderWidth = 1.0
        layer.cornerRadius = 8
        layer.borderColor = UIColor.primary.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
