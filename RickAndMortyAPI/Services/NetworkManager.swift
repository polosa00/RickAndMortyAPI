//
//  NetworkingManager.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
   
    let linkRickAndMorty = URL(string: "https://rickandmortyapi.com/api/character")!
    
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

}
