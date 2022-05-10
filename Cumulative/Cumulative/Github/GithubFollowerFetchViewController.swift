//
//  PlayerNameViewController.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 04.04.2022..
//

import UIKit
import SnapKit
import Combine

class GithubFollowerFetchViewController: UIViewController {

    private let githubSearch = CustomSearch()
    private let searchSpinner = UIActivityIndicatorView()

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background

        configureGithubSearch()
        configureSearchSpinner()
        createDismissKeyboardTapGesture()
    }

    // MARK: views

    private func configureGithubSearch() {
        view.addSubview(githubSearch)

        githubSearch.delegate = self
        githubSearch.placeholder = "Github profile"

        githubSearch.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(view.layoutMarginsGuide)
        }
    }

    private func configureSearchSpinner() {
        view.addSubview(searchSpinner)

        searchSpinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    // MARK: hooks

    @objc private func onSearchClicked() {
        startSearch()

        NetworkManager.shared.fetchGithubFollowers(of: githubSearch.text!)
                      .receive(on: DispatchQueue.main)
                      .sink(
                          receiveCompletion: { [weak self] completion in
                              guard let self = self else { return }

                              self.stopSearch()

                              if case .failure(let error) = completion {
                                  self.showError(error)
                              }
                          },
                          receiveValue: { [weak self] followers in
                              self?.openFollowers(followers)
                          }
                      )
                      .store(in: &cancellables)
    }

    private func startSearch() {
        searchSpinner.startAnimating()
        githubSearch.isUserInteractionEnabled = false
    }

    private func stopSearch() {
        searchSpinner.stopAnimating()
        githubSearch.isUserInteractionEnabled = true
    }

    private func showError(_ error: Error) {
        print(error.localizedDescription)
        let alert = UIAlertController(title: "Error", message: "Couldn't find profile.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }

    private func openFollowers(_ followers: [GithubFollowerResponse]) {
        DispatchQueue.main.async {
            let githubFollowersVC = GithubFollowersViewController(followers: followers)
            githubFollowersVC.title = self.githubSearch.text!
            self.navigationController?.pushViewController(githubFollowersVC, animated: true)
        }
    }

    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension GithubFollowerFetchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == githubSearch {
            searchBar.resignFirstResponder()
            onSearchClicked()
        }
    }
}
