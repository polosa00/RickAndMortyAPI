//
//  NetworkingManager.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation
import Alamofire

enum Link {
    case urlRickAndMorty
    
    var url: URL {
        switch self {
        case .urlRickAndMorty:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
       
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func fetchWithAF(from url: URL?, components: @escaping(Result<RickAndMorty,AFError>) -> Void) {
        guard let url = url else {
            components(.failure(.explicitlyCancelled))
            return
        }
        AF.request(url).validate()
            .responseDecodable(of: RickAndMorty.self) { dataResponse in
                switch dataResponse.result {
                case .success(let rickAndMorty):
                    components(.success(rickAndMorty))
                case .failure(let error):
                    components(.failure(error))
                }
            }
    }
    
    func fetchWithoutAF(from url: URL?, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        guard let url = url else {
            print("invalid link")
            return
        }
        
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
    
    func fetchManual(from url: URL, completion: @escaping(Result<[Character], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters = Character.getCharacter(from: value)
                    completion(.success(characters))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
