//
//  CheckmarksViewController.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit
import SnapKit

class CheckmarksViewController: UIViewController {
    
    let centerImage = UIImageView(image: .checkmark)
    
    let topLeadingImage = UIImageView(image: .checkmark)
    let topTrailingImage = UIImageView(image: .checkmark)
    
    let bottomLeadingImage = UIImageView(image: .checkmark)
    let bottomTrailingImage = UIImageView(image: .checkmark)
    
    enum CheckmarkConfig {
        static let defaultCheckmarkWidth = CGFloat(150)
        static let defaultCheckmarkHeight = CGFloat(150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureCenterImage()
        
        configureTopLeadingImage()
        configureTopTrailingImage()
        
        configureBottomLeadingImage()
        configureBottomTrailingImage()
    }
    
    func configureCenterImage() {
        view.addSubview(centerImage)
        centerImage.translatesAutoresizingMaskIntoConstraints = false
        
        centerImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.layoutMarginsGuide)
            $0.width.equalTo(CheckmarkConfig.defaultCheckmarkWidth)
            $0.height.equalTo(CheckmarkConfig.defaultCheckmarkHeight)
        }
    }
    
    func configureTopLeadingImage() {
        view.addSubview(topLeadingImage)
        topLeadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        topLeadingImage.snp.makeConstraints {
            $0.top.leading.equalTo(view.layoutMarginsGuide)
            $0.width.equalTo(CheckmarkConfig.defaultCheckmarkWidth)
            $0.height.equalTo(CheckmarkConfig.defaultCheckmarkHeight)
        }
    }
    
    func configureTopTrailingImage() {
        view.addSubview(topTrailingImage)
        topTrailingImage.translatesAutoresizingMaskIntoConstraints = false
        
        topTrailingImage.snp.makeConstraints {
            $0.top.trailing.equalTo(view.layoutMarginsGuide)
            $0.width.equalTo(CheckmarkConfig.defaultCheckmarkWidth)
            $0.height.equalTo(CheckmarkConfig.defaultCheckmarkHeight)
        }
    }
    
    func configureBottomLeadingImage() {
        view.addSubview(bottomLeadingImage)
        bottomLeadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLeadingImage.snp.makeConstraints {
            $0.bottom.leading.equalTo(view.layoutMarginsGuide)
            $0.width.equalTo(CheckmarkConfig.defaultCheckmarkWidth)
            $0.height.equalTo(CheckmarkConfig.defaultCheckmarkHeight)
        }
    }
    
    func configureBottomTrailingImage() {
        view.addSubview(bottomTrailingImage)
        bottomTrailingImage.translatesAutoresizingMaskIntoConstraints = false
        
        bottomTrailingImage.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.layoutMarginsGuide)
            $0.width.equalTo(CheckmarkConfig.defaultCheckmarkWidth)
            $0.height.equalTo(CheckmarkConfig.defaultCheckmarkHeight)
        }
    }
}
