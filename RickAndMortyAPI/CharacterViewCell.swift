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
    
    private let networkingManager = NetworkManager.shared
    
    func configure(with character: MovieCharacter) {
        nameLabel.text = character.name
        statusLabel.text = character.status
//        originLabel.text = character.origin.name
        
        networkingManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}



