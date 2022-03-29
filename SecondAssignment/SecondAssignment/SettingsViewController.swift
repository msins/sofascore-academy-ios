//
//  SettingsViewController.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    let darkThemeLabel = ThemeableLabel(text: "Use dark theme:")
    let darkThemeSwitch = ThemeableUISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.background
        
        darkThemeSwitch.isOn = Theme.current == Theme.dark
        
        title = "Settings"
        
        configureThemeLabel()
        configureThemeSwitch()
    }
    
    // MARK: views
    
    func configureThemeLabel() {
        view.addSubview(darkThemeLabel)
        
        darkThemeLabel.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.leading.equalTo(view.layoutMarginsGuide)
        }
    }
    
    func configureThemeSwitch() {
        view.addSubview(darkThemeSwitch)
        
        darkThemeSwitch.addTarget(self, action: #selector(onThemeChanged), for: UIControl.Event.valueChanged)
        
        darkThemeSwitch.snp.makeConstraints {
            $0.centerY.equalTo(darkThemeLabel.snp.centerY)
            $0.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
    
    // MARK: hooks
    
    @objc func onThemeChanged(themeSwitch: UISwitch) {
        Theme.current = themeSwitch.isOn ? Theme.dark : Theme.light
        
        applyTheme()
    }
    
    fileprivate func applyTheme() {
        let isLightTheme = (Theme.current == Theme.light)
        
        view.window?.overrideUserInterfaceStyle = isLightTheme ? .light : .dark
        
        UserDefaults.standard.set(isLightTheme, forKey: Theme.IsLightThemeKey)
        
        view.backgroundColor = Theme.current.background
        darkThemeLabel.onThemeChanged()
        darkThemeSwitch.onThemeChanged()
    }
}
