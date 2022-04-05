//
//  PlayerNameViewController.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit
import SnapKit

class PlayerNameViewController: UIViewController {
    
    var logoImage = CustomImageView(image: UIImage(systemName: "applelogo"))
    var titleLabel = CustomLabel(text: "Enter player name:")
    var playerNameTextField = CustomTextField()
    var nextButton = CustomButton(title: "Next")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        title = "Second assignment"
        
        configureLogoImage()
        configureTitleLabel()
        configureInputTextField()
        configureNextButton()
        
        createDismissKeyboardTapGesture()
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
            $0.bottom.equalTo(view.layoutMarginsGuide).offset(-30)
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
    
    // MARK: helpers
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension PlayerNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == playerNameTextField {
            textField.resignFirstResponder()
            onNextClicked()
            return false
        }
        return true
    }
}
