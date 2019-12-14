//
//  ViewController.swift
//  Kitchen-Master
//
//  Created by Zhihao Wang on 12/13/19.
//  Copyright © 2019 Zhihao Wang. All rights reserved.
//

import UIKit
import SQLite3


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    
    
    @IBOutlet weak var recipeTable: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    
    
    let cellReuseIdentifier = "cell"
    
    var db:RecipeDB = RecipeDB()
    
    var recipes:[Recipe] = []
    
    var query:String = "SELECT * FROM RECIPES where RECIPES.tag = 'shrimp';"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        recipeTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        recipeTable.delegate = self
        recipeTable.dataSource = self
        
        
        recipes = db.read(queryStatement: query)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        cell.textLabel?.text = recipes[indexPath.row].title + "\n" + recipes[indexPath.row].ingredients
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = search.text
        query = "SELECT * FROM RECIPES where RECIPES.tag = '\(keywords ?? "shrimp")'"
        
        recipes = db.read(queryStatement: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("1")
    }
}


