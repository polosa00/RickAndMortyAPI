//
//  CharacterListViewController.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit
//import Alamofire

final class CharacterListViewController: UITableViewController {
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var rickAndMorty: RickAndMorty?
    private var nextPage: URL?

    
    // MARK: - Life Cycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRickAandMorty(from: networkManager.linkRickAndMorty)
//        fetchRAM(from: networkManager.linkRickAndMorty)
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterViewCell else { return UITableViewCell()}
        let character = rickAndMorty?.results[indexPath.row]
        cell.configure(with: character!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = rickAndMorty?.results else { return }
        if results.count - indexPath.row <= 3 {
            getNextPage(from: nextPage)
        }
    }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        if sender.tag == 1 {
            guard let nextUrl = rickAndMorty?.info.next else {
                print("no next link")
                return
            }
            fetchRAM(from: nextUrl)
//            fetchRickAandMorty(from: nextUrl)
        } else {
            guard let prevUrl = rickAndMorty?.info.prev else {
                print("no prev link")
                return
            }
            fetchRAM(from: prevUrl)
//            fetchRickAandMorty(from: prevUrl)
        }
    }
    
    
    
}

// MARK: - Networking
extension CharacterListViewController {
    func fetchRickAandMorty(from url: URL?) {
        networkManager.fetchRAM(from: networkManager.linkRickAndMorty) { [weak self] result in
            switch result {
            case .success(let rickAndMorty):
                self?.rickAndMorty = rickAndMorty
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRAM( from url: URL) {
        networkManager.fetchRickAndMorty(from: url) { [weak self] result in
            switch result {
            case .success(let ric):
                self?.rickAndMorty = ric
                self?.tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func getNextPage(from url: URL?) {
        networkManager.fetchRAM(from: url) { [weak self] result in
            guard let self = self  else { return }
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty?.results.append(contentsOf: rickAndMorty.results)
                self.nextPage = rickAndMorty.info.next
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}


