//
//  ViewController.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var logoImage = ThemeableImageView(image: UIImage(systemName: "applelogo"))
    var titleLabel = ThemeableLabel(text: "Enter player name:")
    var playerNameTextField = ThemeableTextField()
    var nextButton = ThemeableButton(title: "Next")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(
            barButtonSystemItem: UIBarButtonItem.SystemItem.action,
            target: self,
            action: #selector(onSettingsClicked)
        )
        
        title = "Second assignment"
        
        configureLogoImage()
        configureTitleLabel()
        configureInputTextField()
        configureNextButton()
        
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = Theme.current.background
        
        logoImage.onThemeChanged()
        titleLabel.onThemeChanged()
        playerNameTextField.onThemeChanged()
        nextButton.onThemeChanged()
    }
    
    // MARK: views
    
    func configureLogoImage() {
        view.addSubview(logoImage)
        
        logoImage.contentMode = .scaleAspectFit
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.width.equalTo(200)
        }
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureInputTextField() {
        view.addSubview(playerNameTextField)
        
        playerNameTextField.delegate = self
        playerNameTextField.returnKeyType = .next
        
        playerNameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
    }
    
    func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(onNextClicked), for: .touchUpInside)
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    
    // MARK: hooks
    
    @objc func onNextClicked() {
        guard let playerName = playerNameTextField.text, !playerName.isEmpty else {
            let alertView = UIAlertController(title: "Error", message: "Name can't be empty!", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))
            
            present(alertView, animated: true)
            return
        }
        
        DispatchQueue.main.async {
            let profileViewController = ProfileViewController()
            profileViewController.title = playerName
            
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    @objc func onSettingsClicked() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }
    }
    
    // MARK: helpers
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == playerNameTextField {
            textField.resignFirstResponder()
            onNextClicked()
            return false
        }
        return true
    }
}
