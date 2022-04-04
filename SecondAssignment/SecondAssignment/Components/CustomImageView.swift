//
//  CustomImageView.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import UIKit

class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        tintColor = .primaryText
    }
}
