//
// Created by Marko Sinkovic on 09.04.2022..
//

import UIKit
import SnapKit

class FollowerCollectionCell: UICollectionViewCell {
    private let avatar = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        configureAvatar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(follower: GithubFollowerResponse) {
        avatar.sd_setImage(with: URL(string: follower.avatarUrl))
    }

    // MARK: views

    private func configureAvatar() {
        contentView.addSubview(avatar)

        avatar.sd_imageTransition = .fade
        avatar.layer.cornerRadius = 8;
        avatar.layer.masksToBounds = true;

        avatar.snp.makeConstraints {
            $0.bottom.top.leading.trailing.equalTo(self.contentView.layoutMarginsGuide)
        }
    }
}

