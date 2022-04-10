//
// Created by Marko Sinkovic on 09.04.2022..
//

import UIKit
import SnapKit
import SDWebImage

class GithubFollowersViewController: UICollectionViewController {

    private let followers: [GithubFollowerResponse]

    private let interItemSpacing = CGFloat(10)
    private let itemsPerRow = 3

    private let userHasNoFollowersLabel = CustomLabel(text: "User has no followers 😔")

    enum CellType {
        static let follower = "follower"
    }

    init(followers: [GithubFollowerResponse]) {
        self.followers = followers
        super.init(collectionViewLayout: UICollectionViewFlowLayout.init())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Followers"

        collectionView.delegate = self
        collectionView.backgroundColor = .background
        collectionView.register(FollowerCollectionCell.self, forCellWithReuseIdentifier: CellType.follower)

        if followers.count == 0 {
            configureUserHasNoFollowersLabel()
        }
    }

    // MARK: views

    private func configureUserHasNoFollowersLabel() {
        view.addSubview(userHasNoFollowersLabel)

        userHasNoFollowersLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.layoutMarginsGuide)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        followers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.follower, for: indexPath) as! FollowerCollectionCell

        cell.bind(follower: followers[indexPath.row])

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let githubProfileVC = GithubProfileViewController(follower: followers[indexPath.row])
        present(UINavigationController(rootViewController: githubProfileVC), animated: true)
    }
}

extension GithubFollowersViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideMargins = collectionView.layoutMargins.left + collectionView.layoutMargins.right
        let interItemSpacing = CGFloat(itemsPerRow - 1) * interItemSpacing
        let size = (collectionView.frame.width - sideMargins - interItemSpacing) / CGFloat(itemsPerRow)

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CoreGraphics.CGFloat {
        interItemSpacing
    }
}
