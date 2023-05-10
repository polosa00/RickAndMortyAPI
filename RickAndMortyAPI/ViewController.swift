//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit

class ViewController: UIViewController {
    let linkRic: URL = URL(string: "https://rickandmortyapi.com/api/character")!
    
//    private let networkManager = NetworkManager.shared
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRic()
        // Do any additional setup after loading the view.
    }
    
//    func fetchCharacters() {
//        networkManager.fetch([MovieCharacter].self, from: Link.charactersURL.url) { result in
//            switch result {
//            case .success(let characters):
//                print(characters)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let charactersVC = segue.destination as? CharacterListViewController else { return }
//        charactersVC.fetchCharacters()
    }

    
    func fetchRic() {
        URLSession.shared.dataTask(with: Link.charactersURL.url) { data, _, error in
            
            
            guard let data else {
                print(error?.localizedDescription ?? "KKK")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(Results.self, from: data)
                print(characters)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

}



