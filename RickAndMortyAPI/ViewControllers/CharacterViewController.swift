//
//  CharacterViewController.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 12.05.23.
//

import UIKit

final class CharacterViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var characterStatusLabel: UILabel!
    @IBOutlet var characterSpeciesLabel: UILabel!
    @IBOutlet var characterGenderLabel: UILabel!
    @IBOutlet var characterOriginLabel: UILabel!
    @IBOutlet var characterLocationLabel: UILabel!
    
    var character: Character!
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterNameLabel.text = character.name
        characterStatusLabel.text = character.status
        characterSpeciesLabel.text = character.species
        characterGenderLabel.text = character.gender
//        characterOriginLabel.text = character.origin.name
//        characterLocationLabel.text = character.location.name
        
        networkManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
