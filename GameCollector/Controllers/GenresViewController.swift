//
//  GenreListController.swift
//  GameCollector
//
//  Created by Diogo Muller on 20/01/19.
//  Copyright © 2019 Diogo Muller. All rights reserved.
//

import Foundation
import UIKit

class GenresViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var genres : [Genre] = []
    var parentList : GamesViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        genres = PersistedData.genres.map({ (key, value) -> Genre in
            return value
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genre = genres[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell")
        
        cell?.textLabel!.text = genre.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = genres[(indexPath as NSIndexPath).row]
        
        parentList.filterGenre = Int(genre.id)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}