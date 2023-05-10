//
//  NetworkingManager.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation

enum Link {
    case charactersURL
    
    var url: URL {
        switch self {
        case .charactersURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

enum NetworkingError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data,NetworkingError>) -> Void) {
        guard let imageData = try? Data(contentsOf: url) else {
            completion(.failure(.noData))
            return
        }
        DispatchQueue.main.async {
            completion(.success(imageData))
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, NetworkingError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    
    
}
