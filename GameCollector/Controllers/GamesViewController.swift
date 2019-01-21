//
//  GamesViewController.swift
//  GameCollector
//
//  Created by Diogo Muller on 13/01/19.
//  Copyright © 2019 Diogo Muller. All rights reserved.
//

import UIKit

enum GameFilterType {
    case none, genre, platform
}

class GamesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var games : [Game] = []
    
    var filterGenre : Int? = nil
    var filterPlatform : Int? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textSearch: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view, typically from a nib.
        var filters : [String] = []
        
        let search = textSearch!.text
        
        if let genre = filterGenre {
            filters.append("genres = \(genre)")
        }
        
        if let platform = filterPlatform {
            filters.append("platform = \(platform)")
        }
        
        IGDBClient.instance.getGames(limit: 50, offset: 0, search: search!, filters: filters) { (result, error) in
            guard error == nil else {
                self.showMessage("Error", error!.localizedDescription)
                return
            }
            
            let games = result ?? []
            
            self.games = []
            
            for gameData in games {
                let game = PersistedData.createOrUpdateGame(gameData)
                self.games.append(game)
            }
            
            PersistedData.save()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let genresView = segue.destination as? GenresViewController {
            genresView.parentList = self
        }
    }
    
    @IBAction func showFilters(_ sender: Any) {
        performSegue(withIdentifier: "showGenres", sender: self)
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: UITableViewDataSource
    //////////////////////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = games[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell")

        cell?.textLabel!.text = game.name
        
        return cell!

    }


}

