//
//  CharacterListViewController.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit

final class CharacterListViewController: UITableViewController {
    
    private let linkRick: URL = URL(string: "https://rickandmortyapi.com/api/character")!
    private let networkManager = NetworkManager.shared
    var ricAndMorty: RickAndMorty?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRic()
        tableView.rowHeight = 128
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ricAndMorty?.results.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterViewCell else { return UITableViewCell()}
        let character = ricAndMorty?.results[indexPath.row]
        cell.configure(with: character!)
        return cell
    }
    
    
    
}

extension CharacterListViewController {
    func fetchRic() {
        
//        networkManager.fetch(RickAndMorty.self, from: linkRick) { [weak self] result in
//            switch result {
//            case .success(let characters):
//                self?.ricAndMorty = characters
//                print(characters)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        URLSession.shared.dataTask(with: linkRick) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "KKK")
                return
            }
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(RickAndMorty.self, from: data)
                self.ricAndMorty = characters
                print(characters)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
