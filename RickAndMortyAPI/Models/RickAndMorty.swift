//
//  Character.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation


struct RickAndMorty: Decodable {
    let info: Info
    var results: [Character]

}

struct Info: Decodable {
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct Character:Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
//    let location: Location
//    let origin: Location
    
    
    init(name: String, status: String, species: String, gender: String, image: String) {
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
    }
        
    init(from characterData: [String: Any]) {
        name = characterData["name"] as? String ?? ""
        status = characterData["status"] as? String ?? ""
        species = characterData["species"] as? String ?? ""
        gender = characterData["gender"] as? String ?? ""
        image = characterData["image"] as? String ?? ""
    }
    
    static func getCharacter(from value: Any) -> [Character] {
        guard let resultsData = (value as? [String: Any])?["results"] as? [Any] else { return [] }
        guard let charactersData = resultsData as? [[String: Any]] else { return []}
        
        return charactersData.map { Character(from: $0) }
    }
        
        
        
}
//
//struct Location: Decodable {
//    let name: String
//}

