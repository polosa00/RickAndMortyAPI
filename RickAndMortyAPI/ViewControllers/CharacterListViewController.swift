//
//  CharacterListViewController.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit

final class CharacterListViewController: UITableViewController {
    
    // MARK: - Properties
    private let linkRickAndMorty: URL = URL(string: "https://rickandmortyapi.com/api/character")!
    private let networkManager = NetworkManager.shared
    private var rickAndMorty: RickAndMorty?
    
    
    // MARK: - Life Cycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRicAndMorty()

    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterViewCell else { return UITableViewCell()}
        let character = rickAndMorty?.results[indexPath.row]
        cell.configure(with: character!)
        return cell
    }
}

// MARK: - Networking
extension CharacterListViewController {
    func fetchRicAndMorty() {
        networkManager.fetchRickAndMorty(from: linkRickAndMorty) { [weak self] result in
            switch result {
            case .success(let rickAndMorty):
                self?.rickAndMorty = rickAndMorty
                self?.tableView.reloadData()
                print(rickAndMorty)
            case .failure(let error):
                print(error)
            }
        }
    }
}
