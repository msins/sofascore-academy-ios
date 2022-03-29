//
//  CustomImageView.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import Foundation
import UIKit

class ThemeableImageView: UIImageView, Themeable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        onThemeChanged()
    }
    
    func onThemeChanged() {
        tintColor = Theme.current.primaryText
    }
}
