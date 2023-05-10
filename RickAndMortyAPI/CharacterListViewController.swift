//
//  CharacterListViewController.swift
//  RickAndMortyAPI
//
//  Created by Александр Полочанин on 9.05.23.
//

import UIKit

final class CharacterListViewController: UITableViewController {

    var characters: [MovieCharacter] = []
    let networkManager = NetworkManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 128
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterViewCell else { return UITableViewCell()}
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let charactersVC = segue.destination as? CharacterListViewController else { return }
//        charactersVC.fetchCharacters()
//    }
    

}
//
//extension CharacterListViewController {
//    func fetchCharacters() {
//        URLSession.shared.dataTask(with: Link.charactersURL.url) { [self] data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                self.characters = try decoder.decode([MovieCharacter].self, from: data)
//               print(characters)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//}
