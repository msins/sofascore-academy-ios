//
//  GithubFavouritesViewController.swift
//  Cumulative
//
//  Created by Marko Sinkovic on 08.05.2022..
//

import UIKit
import SnapKit
import Combine

class GithubFavouritesViewController: UITableViewController {
    
    private var favorites = [Follower]()
    private var cancellables = Set<AnyCancellable>()
    
    enum CellType {
        static let favorite = "favorite"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.register(FavoriteTableCell.self, forCellReuseIdentifier: CellType.favorite)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PersistenceManager.favorites()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] favorites in
                guard let self = self else { return }
                
                self.favorites = favorites
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).store(in: &cancellables)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.favorite, for: indexPath) as! FavoriteTableCell
        
        let favorite = favorites[indexPath.row]
        cell.bind(login: favorite.login, avatarUrl: favorite.avatarUrl)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        
        DispatchQueue.main.async {
            self.navigationController?.present(UINavigationController(rootViewController: GithubProfileViewController(login: favorite.login)), animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            PersistenceManager.favorite(.remove, follower: favorites[indexPath.row])
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self = self else { return }
                        
                        if case .failure(let error) = completion {
                            self.showError(error)
                        }
                    },
                    receiveValue: { [weak self] favorite in
                        guard let self = self else { return }
                    
                        DispatchQueue.main.async {
                            self.favorites.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                ).store(in: &cancellables)
        }
    }
    
    private func showError(_ error: Error) {
        print(error.localizedDescription)
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
}
