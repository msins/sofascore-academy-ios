//
// Created by Marko Sinkovic on 30.04.2022..
//

import UIKit
import SnapKit

class ProfileFollowersSection: UIView {
    private let followersButton = CustomButton(title: "Get followers", color: .githubFollowersButton)
    private let followersLoadingIndicator = UIActivityIndicatorView()
    
    private let followersLabel = CustomLabel(text: "Followers")
    private let followersCountLabel = CustomLabel()
    
    private let followingLabel = CustomLabel(text: "Following")
    private let followingCountLabel = CustomLabel()
    
    private var followers: Int
    private var following: Int
    
    var handleFollowersClicked: (() -> Void)?
    
    private enum Constraints {
        static let padding = 30
    }
    
    init(frame: CGRect = .zero, followers: Int, following: Int) {
        self.followers = followers
        self.following = following
        
        super.init(frame: frame)
        
        backgroundColor = .githubSectionBackground.withAlphaComponent(0.1)
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        configureFollowersInformation()
        configureFollowingInformation()
        
        configureFollowersButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureFollowersInformation() {
        addSubview(followersLabel)
        addSubview(followersCountLabel)
        
        followersCountLabel.text = String(followers)
        
        followersLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(Constraints.padding)
            $0.leading.equalTo(self.snp.leading).offset(Constraints.padding)
        }
        
        followersCountLabel.snp.makeConstraints {
            $0.centerX.equalTo(followersLabel)
            $0.top.equalTo(followersLabel.snp.bottom).offset(5)
        }
    }
    
    private func configureFollowingInformation() {
        addSubview(followingLabel)
        addSubview(followingCountLabel)
        
        followingCountLabel.text = String(following)
        
        followingLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(Constraints.padding)
            $0.trailing.equalTo(self.snp.trailing).inset(Constraints.padding)
        }
        
        followingCountLabel.snp.makeConstraints {
            $0.centerX.equalTo(followingLabel)
            $0.top.equalTo(followingLabel.snp.bottom).offset(5)
        }
    }
    
    private func configureFollowersButton() {
        addSubview(followersButton)
        
        followersButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        followersButton.setTitleColor(.white, for: .normal)
        followersButton.titleLabel?.font = .systemFont(ofSize: 18)
        followersButton.addTarget(self, action: #selector(onGetFollowersClicked), for: .touchUpInside)
        
        followersButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(Constraints.padding)
            $0.leading.equalTo(self.snp.leading).offset(Constraints.padding)
            $0.trailing.equalTo(self.snp.trailing).inset(Constraints.padding)
        }
    }
    
    public func startLoading() {
        followersButton.isEnabled = false
        followersButton.setTitle("", for: .normal)
        
        addSubview(followersLoadingIndicator)
        followersLoadingIndicator.snp.makeConstraints {
            $0.center.equalTo(followersButton.center)
        }
        
        followersLoadingIndicator.startAnimating()
    }
    
    public func stopLoading() {
        followersButton.isEnabled = true
        followersButton.setTitle("Get followers", for: .normal)
        
        followersLoadingIndicator.stopAnimating()
        followersLoadingIndicator.removeFromSuperview()
    }
    
    @objc private func onGetFollowersClicked() {
        handleFollowersClicked?()
    }
}
