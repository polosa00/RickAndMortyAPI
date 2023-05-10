//
//  Character.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation


struct RickAndMorty: Decodable {
    let info: Info
    let results: [MovieCharacters]
}

struct Info: Decodable {
    let pages: Int
    let next: URL?
}

struct MovieCharacters:Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: URL
//    let location: Location
}
