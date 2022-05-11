//
// Created by Marko Sinkovic on 30.04.2022..
//

import UIKit
import SnapKit

class ProfileDetailsSection: UIView {
    private let profileButton = CustomButton(title: "Github profile", color: .githubProfileButton)
    
    private let reposLabel = CustomLabel(text: "Public repos")
    private let reposCountLabel = CustomLabel()
    
    private let gistsLabel = CustomLabel(text: "Public gists")
    private let gistsCountLabel = CustomLabel()
    
    private let repos: Int
    private let gists: Int
    
    var handleDetailsClicked: (() -> Void)?
    
    private enum Constraints {
        static let padding = 30
    }
    
    init(frame: CGRect = .zero, repos: Int, gists: Int) {
        self.repos = repos
        self.gists = gists
        
        super.init(frame: frame)
        
        backgroundColor = .githubSectionBackground.withAlphaComponent(0.1)
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        configureReposInformation()
        configureGistsInformation()
        
        configureProfileButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureReposInformation() {
        addSubview(reposLabel)
        addSubview(reposCountLabel)
        
        reposCountLabel.text = String(repos)
        
        reposLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(Constraints.padding)
            $0.leading.equalTo(self.snp.leading).offset(Constraints.padding)
        }
        
        reposCountLabel.snp.makeConstraints {
            $0.centerX.equalTo(reposLabel)
            $0.top.equalTo(reposLabel.snp.bottom).offset(5)
        }
    }
    
    private func configureGistsInformation() {
        addSubview(gistsLabel)
        addSubview(gistsCountLabel)
        
        gistsCountLabel.text = String(gists)
        
        gistsLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(Constraints.padding)
            $0.trailing.equalTo(self.snp.trailing).inset(Constraints.padding)
        }
        
        gistsCountLabel.snp.makeConstraints {
            $0.centerX.equalTo(gistsLabel)
            $0.top.equalTo(gistsLabel.snp.bottom).offset(5)
        }
    }
    
    private func configureProfileButton() {
        addSubview(profileButton)
        
        profileButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.titleLabel?.font = .systemFont(ofSize: 18)
        profileButton.addTarget(self, action: #selector(onProfileClicked), for: .touchUpInside)
        
        profileButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(Constraints.padding)
            $0.leading.equalTo(self.snp.leading).offset(Constraints.padding)
            $0.trailing.equalTo(self.snp.trailing).inset(Constraints.padding)
        }
    }
    
    @objc private func onProfileClicked() {
        handleDetailsClicked?()
    }
}
