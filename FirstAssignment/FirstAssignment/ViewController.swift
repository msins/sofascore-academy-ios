//
//  ViewController.swift
//  FirstAssignment
//
//  Created by Marko Sinkovic on 22.03.2022..
//

import UIKit

class ViewController: UIViewController {
    
    let centerImage = UIImageView(image: .checkmark)
    
    let topLeadingImage = UIImageView(image: .checkmark)
    let topTrailingImage = UIImageView(image: .checkmark)
    
    let bottomLeadingImage = UIImageView(image: .checkmark)
    let bottomTrailingImage = UIImageView(image: .checkmark)
    
    struct CheckmarkConfig {
        static let defaultCheckmarkWidth = CGFloat(150)
        static let defaultCheckmarkHeight = CGFloat(150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCenterImage()
        
        configureTopLeadingImage()
        configureTopTrailingImage()
        
        configureBottomLeadingImage()
        configureBottomTrailingImage()
    }
    
    func configureCenterImage() {
        view.addSubview(centerImage)
        centerImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerImage.widthAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkWidth),
            centerImage.heightAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkHeight),
            centerImage.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            centerImage.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        ])
    }
    
    func configureTopLeadingImage() {
        view.addSubview(topLeadingImage)
        topLeadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLeadingImage.widthAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkWidth),
            topLeadingImage.heightAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkHeight),
            topLeadingImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topLeadingImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
    }
    
    func configureTopTrailingImage() {
        view.addSubview(topTrailingImage)
        topTrailingImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topTrailingImage.widthAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkWidth),
            topTrailingImage.heightAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkHeight),
            topTrailingImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topTrailingImage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func configureBottomLeadingImage() {
        view.addSubview(bottomLeadingImage)
        bottomLeadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomLeadingImage.widthAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkWidth),
            bottomLeadingImage.heightAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkHeight),
            bottomLeadingImage.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            bottomLeadingImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    func configureBottomTrailingImage() {
        view.addSubview(bottomTrailingImage)
        bottomTrailingImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomTrailingImage.widthAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkWidth),
            bottomTrailingImage.heightAnchor.constraint(equalToConstant: CheckmarkConfig.defaultCheckmarkHeight),
            bottomTrailingImage.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            bottomTrailingImage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}

