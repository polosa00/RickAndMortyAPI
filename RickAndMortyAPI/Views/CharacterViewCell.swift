//
//  CharacterViewCell.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit

final class CharacterViewCell: UITableViewCell {

    @IBOutlet var characterImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    
    func configure( with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = character.status
        speciesLabel.text = character.species
        
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



