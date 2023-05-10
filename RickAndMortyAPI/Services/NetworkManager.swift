//
//  NetworkingManager.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
   
    let linkRickAndMorty: URL = URL(string: "https://rickandmortyapi.com/api/character")!
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchRickAndMorty(from url: URL, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let rickAndMorty = try decoder.decode(RickAndMorty.self, from: data)
                print(rickAndMorty)
                DispatchQueue.main.async {
                    completion(.success(rickAndMorty))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
