//
//  CharacterViewCell.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit

class CharacterViewCell: UITableViewCell {

    @IBOutlet var characterImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    
    let networkManager = NetworkManager.shared
    
    func configure( with character: MovieCharacters) {
        nameLabel.text = character.name
        statusLabel.text = character.status
        originLabel.text = character.species
        
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



