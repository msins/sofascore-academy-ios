//
//  ProfileViewController.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 29.03.2022..
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let sofaScoreLabel = ThemeableLabel(text: "SofaScore Academy")
    let sofaScoreButton = ThemeableButton(title: "SofaScore")
    let loremIpsumLabel = ThemeableLabel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur cursus, ante et sodales congue, ligula ex consequat lacus, tincidunt auctor dolor diam vitae velit. Nam quis convallis mauris, nec lobortis purus. Vivamus a fermentum nisi. Maecenas accumsan leo sit amet efficitur ornare. Ut porttitor arcu eget fermentum pulvinar. Vestibulum scelerisque, neque ac scelerisque ultrices, mi ex volutpat odio, id eleifend velit sem sed lectus. Phasellus luctus leo felis, vel venenatis urna tempor vel. Suspendisse sed lacus vel mi suscipit mattis. Aliquam convallis dolor vitae urna tincidunt, at efficitur sem fermentum. Etiam pharetra faucibus ex. Phasellus tempor dapibus erat, id tincidunt nisl convallis fermentum. Duis tempor sem scelerisque libero consectetur faucibus. Vestibulum gravida euismod dui eu maximus.", font: .title.withSize(12))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.background
        
        configureSofaScoreLabel()
        configureSofaScoreButton()
        configureLoremIpsumLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = Theme.current.background
        
        sofaScoreLabel.onThemeChanged()
        sofaScoreButton.onThemeChanged()
        loremIpsumLabel.onThemeChanged()
    }
    
    // MARK: views
    
    func configureSofaScoreLabel() {
        view.addSubview(sofaScoreLabel)
        
        sofaScoreLabel.font = .title.withSize(32)
        
        sofaScoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.layoutMarginsGuide).offset(30)
        }
    }
    
    func configureSofaScoreButton() {
        view.addSubview(sofaScoreButton)
        
        sofaScoreButton.addTarget(self, action: #selector(onSofaScoreClicked), for: .touchUpInside)
        
        sofaScoreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    
    func configureLoremIpsumLabel() {
        view.addSubview(loremIpsumLabel)
        
        loremIpsumLabel.numberOfLines = 0
        
        loremIpsumLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(sofaScoreLabel.snp.bottom).offset(15)
        }
    }
    
    // MARK: hooks
    
    @objc func onSofaScoreClicked() {
        UIApplication.shared.open(URL(string: "https://sofascore.com")!)
    }
}
