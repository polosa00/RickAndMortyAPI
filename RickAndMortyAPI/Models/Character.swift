//
//  Character.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation


struct Results: Decodable {
//    let count: Int
    let characters: [MovieCharacter]
    
}

struct MovieCharacter: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let image: URL
    let origin: Origin
}

struct Origin: Decodable {
    let name: String
    let url: URL
}
