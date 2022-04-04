//
//  CustomUISwitch.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 29.03.2022..
//

import UIKit

class CustomUISwitch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        self.onTintColor = .primary
        self.thumbTintColor = .background
    }
}
