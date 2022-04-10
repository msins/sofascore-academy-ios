//
//  ProfileViewController.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit
import SnapKit
import Combine

typealias Information = (key: String, value: String)

class GithubProfileViewController: UIViewController {

    private let avatar = UIImageView()

    private let informationTableView = UITableView()
    private var information = [Information]()

    private let loadingSpinner = UIActivityIndicatorView()

    private let login: String

    private enum CellType {
        static let information = "information"
    }

    private var cancellables = Set<AnyCancellable>()

    init(follower: GithubFollowerResponse) {
        login = follower.login
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
        configureInformationTableView()

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

    private func configureLoadingSpinner() {
        view.addSubview(loadingSpinner)

        loadingSpinner.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.layoutMarginsGuide)
        }
    }

    private func configureDoneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onDoneClicked)
        )
    }

    private func configureAvatar() {
        view.addSubview(avatar)

        avatar.sd_imageTransition = .fade
        avatar.layer.cornerRadius = 8
        avatar.layer.masksToBounds = true

        avatar.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.layoutMarginsGuide)
        }
    }

    private func configureInformationTableView() {
        view.addSubview(informationTableView)

        informationTableView.isScrollEnabled = false
        informationTableView.backgroundColor = .background
        informationTableView.separatorStyle = .singleLine
        informationTableView.dataSource = self
        informationTableView.register(ProfileInformationTableCell.self, forCellReuseIdentifier: CellType.information)

        informationTableView.snp.makeConstraints {
            $0.top.equalTo(avatar.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide)
        }
    }

    // MARK: hooks

    private func onProfileLoaded(_ profile: GithubProfileResponse) {
        navigationItem.title = profile.login.appending(profile.name != nil ? " (\(profile.name!))" : "")
        avatar.sd_setImage(with: URL(string: profile.avatarUrl))

        information.append(Information(key: "Followers", value: profile.followers.description))
        information.append(Information(key: "Following", value: profile.following.description))
        information.append(Information(key: "Public gists", value: profile.publicGists.description))
        information.append(Information(key: "Public repos", value: profile.publicRepos.description))
        information.append(Information(key: "Company", value: profile.company ?? "-"))

        informationTableView.reloadData()
    }

    @objc private func onDoneClicked() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true)
        }
    }
}

extension GithubProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        information.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = informationTableView.dequeueReusableCell(withIdentifier: CellType.information) as! ProfileInformationTableCell

        let information = information[indexPath.row]

        cell.bind(key: information.key, value: information.value)

        return cell
    }
}