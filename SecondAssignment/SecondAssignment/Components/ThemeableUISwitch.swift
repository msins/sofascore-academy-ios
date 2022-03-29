//
//  CustomUISwitch.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 29.03.2022..
//

import Foundation
import UIKit

class ThemeableUISwitch: UISwitch, Themeable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        onThemeChanged()
    }
    
    func onThemeChanged() {
        self.onTintColor = Theme.current.primary
        self.thumbTintColor = Theme.current.background
    }
}
