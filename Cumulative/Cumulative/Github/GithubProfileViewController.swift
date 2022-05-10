//
//  ProfileViewController.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit
import SnapKit
import Combine
import SafariServices

class GithubProfileViewController: UIViewController {
    
    private let avatar = UIImageView()
    private let usernameLabel = CustomLabel()
    private let fullnameLabel = CustomLabel()
    
    private let bio = CustomLabel()
    
    private let locationIcon = CustomImageView(image: UIImage(systemName: "location"))
    private let locationLabel = CustomLabel()
    
    private var followersSection = ProfileFollowersSection(followers: 0, following: 0)
    private var detailsSection = ProfileDetailsSection(repos: 0, gists: 0)
    
    private var userSinceLabel = CustomLabel()
    private let userSinceDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }()
    
    private let loadingSpinner = UIActivityIndicatorView()
    
    private let login: String
    private var profile: GithubProfileResponse?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(login: String) {
        self.login = login
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        configureDoneButton()
        configureAvatar()
        
        configureLoadingSpinner()
        loadingSpinner.startAnimating()
        
        NetworkManager.shared.fetchGithubProfile(of: login)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.loadingSpinner.stopAnimating()
                    
                    if case .failure(_) = completion {
                        self.onDoneClicked()
                    }
                },
                receiveValue: { [weak self] profile in
                    self?.onProfileLoaded(profile)
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureLoadingSpinner() {
        view.addSubview(loadingSpinner)
        
        loadingSpinner.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.layoutMarginsGuide)
        }
    }
    
    private func configureDoneButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onDoneClicked)
        )
    }
    
    private func configureFavoriteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onFavoriteClicked)
        )
    }
    
    private func configureAvatar() {
        view.addSubview(avatar)
        
        avatar.sd_imageTransition = .fade
        avatar.layer.cornerRadius = 8
        avatar.layer.masksToBounds = true
        
        avatar.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(view.layoutMarginsGuide)
        }
    }
    
    private func configureUsername() {
        view.addSubview(usernameLabel)
        
        usernameLabel.text = login
        usernameLabel.font = .boldSystemFont(ofSize: 28)
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatar.snp.top)
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
        }
    }
    
    private func configureName() {
        view.addSubview(fullnameLabel)
        
        fullnameLabel.text = profile!.name
        fullnameLabel.font = .systemFont(ofSize: 16)
        
        fullnameLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom)
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
        }
    }
    
    private func configureBio() {
        view.addSubview(bio)
        
        bio.text = profile!.bio
        bio.numberOfLines = 0
        bio.font = .systemFont(ofSize: 14)
        
        bio.snp.makeConstraints {
            $0.top.equalTo(avatar.snp.bottom).offset(15)
            $0.leading.equalTo(view.layoutMarginsGuide)
            $0.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
    
    private func configureLocation() {
        view.addSubview(locationIcon)
        view.addSubview(locationLabel)
        
        locationIcon.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
            $0.bottom.equalTo(avatar.snp.bottom)
        }
        
        locationLabel.text = profile!.location
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationIcon.snp.trailing)
            $0.centerY.equalTo(locationIcon)
        }
    }
    
    private func configureDetailsSection() {
        detailsSection = ProfileDetailsSection(repos: profile!.publicRepos, gists: profile!.publicGists)
        self.view.addSubview(detailsSection)
        
        detailsSection.handleDetailsClicked = {
            let detailsController = SFSafariViewController(url: URL(string: self.profile!.htmlUrl)!)
            DispatchQueue.main.async {
                self.navigationController?.present(detailsController, animated: true)
            }
        }
        
        detailsSection.snp.makeConstraints {
            if profile!.bio != nil {
                $0.top.equalTo(bio.snp.bottom).offset(15)
            } else {
                $0.top.equalTo(avatar.snp.bottom).offset(15)
            }
            $0.trailing.equalTo(view.layoutMarginsGuide)
            $0.leading.equalTo(view.layoutMarginsGuide)
            $0.height.equalTo(175)
        }
    }
    
    private func showError(_ error: Error) {
        print(error.localizedDescription)
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
    
    private func configureFollowersSection() {
        followersSection = ProfileFollowersSection(followers: profile!.followers, following: profile!.following)
        self.view.addSubview(followersSection)
        
        followersSection.handleFollowersClicked = {
            self.followersSection.startLoading()
            
            NetworkManager.shared.fetchGithubFollowers(of: self.profile!.login)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self = self else { return }
                        
                        self.followersSection.stopLoading()
                        
                        if case .failure(let error) = completion {
                            self.showError(error)
                        }
                    },
                    receiveValue: { [weak self] followers in
                        guard let self = self else { return }
                        
                        DispatchQueue.main.async {
                            let followersController = GithubFollowersViewController(followers: followers)
                            followersController.title = self.login
                            self.navigationController?.pushViewController(followersController, animated: true)
                        }
                    }
                )
                .store(in: &self.cancellables)
        }
        
        
        followersSection.snp.makeConstraints {
            $0.top.equalTo(detailsSection.snp.bottom).offset(15)
            $0.trailing.equalTo(view.layoutMarginsGuide)
            $0.leading.equalTo(view.layoutMarginsGuide)
            $0.height.equalTo(175)
        }
    }
    
    private func configureUserSince() {
        view.addSubview(userSinceLabel)
        
        userSinceLabel.text = "User since \(userSinceDateFormatter.string(from: profile!.createdAt))"
        
        userSinceLabel.snp.makeConstraints {
            $0.top.equalTo(followersSection.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: hooks
    
    private func onProfileLoaded(_ profile: GithubProfileResponse) {
        self.profile = profile
        
        avatar.sd_setImage(with: URL(string: profile.avatarUrl))
        
        if profile.location != nil {
            configureLocation()
        }
        
        configureUsername()
        
        if profile.name != nil {
            configureName()
        }
        
        if profile.bio != nil {
            configureBio()
        }
        
        configureFavoriteButton()
        configureDetailsSection()
        configureFollowersSection()
        configureUserSince()
    }
    
    @objc private func onDoneClicked() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    
    @objc private func onFavoriteClicked() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        PersistenceManager.favorite(.add, follower: Follower(login: profile!.login, avatarUrl: profile!.avatarUrl))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    
                    if case .failure(let error) = completion {
                        self.showError(error)
                    }
                },
                receiveValue: { [weak self] favorite in
                    guard let self = self else { return }
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Success", message: "\(favorite.login) added to favorites.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in }))

                        self.present(alert, animated: true)
                    }
                }
            ).store(in: &cancellables)
        
        
    }
}
