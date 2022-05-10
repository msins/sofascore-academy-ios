//
//  FavoriteTableCell.swift
//  Cumulative
//
//  Created by Marko Sinkovic on 08.05.2022..
//

import UIKit

class FavoriteTableCell: UITableViewCell {
    
    private let avatar = UIImageView()
    private let username = CustomLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .background
        
        configureAvatar()
        configureUsername()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(login: String, avatarUrl: String) {
        username.text = login
        avatar.sd_setImage(with: URL(string: avatarUrl))
    }
    
    private func configureAvatar() {
        contentView.addSubview(avatar)
        
        avatar.sd_imageTransition = .fade
        avatar.layer.cornerRadius = 8;
        avatar.layer.masksToBounds = true;
        
        avatar.snp.makeConstraints {
            $0.centerY.equalTo(contentView.layoutMarginsGuide)
            $0.leading.equalTo(contentView.layoutMarginsGuide)
            $0.width.height.equalTo(75)
        }
    }
    
    private func configureUsername() {
        contentView.addSubview(username)
        
        username.snp.makeConstraints {
            $0.centerY.equalTo(avatar)
            $0.leading.equalTo(avatar.snp.trailing).offset(20)
        }
    }
}
