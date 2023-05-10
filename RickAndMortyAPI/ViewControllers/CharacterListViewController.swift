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
   
    var rickAndMorty: RickAndMorty?
    
    
    // MARK: - Life Cycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRic()

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
    func fetchRic() {
        
//        networkManager.fetchRickAndMorty(from: linkRick) { [weak self] result in
//            switch result {
//            case .success(let rickAndMorty):
//                self?.rickAndMorty = rickAndMorty
//                print(rickAndMorty)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        URLSession.shared.dataTask(with: linkRickAndMorty) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(RickAndMorty.self, from: data)
                self.rickAndMorty = characters
                print(characters)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
