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
    
    @IBAction func moreButton(_ sender: Any) {
        
    }
    
    let cellReuseIdentifier = "cell"
    
    var db:RecipeDB = RecipeDB()
    
    var recipes:[Recipe] = []
    var currentRecipes = [Recipe]()
    var currenttitle:String?
    var currentingred:String?
    var currentins:String?
    
    var query:String = "SELECT * FROM RECIPES;"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue") {
            let vc = segue.destination as! viewPage
            vc.titletext = currenttitle
            vc.ingredtext = currentingred
            vc.instext = currentins
        }
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        recipeTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        recipeTable.delegate = self
        recipeTable.dataSource = self
        
        
        recipes = db.read(queryStatement: query)
        currentRecipes = recipes
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else{
            return UITableViewCell()
        }
        cell.titleLbl.text = currentRecipes[indexPath.row].title
        cell.titleLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        cell.ingredLbl.text = currentRecipes[indexPath.row].ingredients
        
        return cell
        
        /*
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        cell.textLabel?.text = recipes[indexPath.row].title + recipes[indexPath.row].instruction
        return cell
 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currenttitle = currentRecipes[indexPath.row].title
        currentingred = currentRecipes[indexPath.row].ingredients
        currentins = currentRecipes[indexPath.row].instruction
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    private func setupSearchbar(){
        search.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        currentRecipes = db.read(queryStatement: "SELECT * FROM RECIPES where RECIPES.tag = '\(search.text?.lowercased() ?? "beef")';")
        
        recipeTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
       
        if search.selectedScopeButtonIndex == 0 {
             currentRecipes = db.read(queryStatement: "SELECT * FROM meat;")
             recipeTable.reloadData()
        }else if search.selectedScopeButtonIndex == 1
        {
            currentRecipes = db.read(queryStatement: "SELECT * FROM vegetable;")
            recipeTable.reloadData()
        }
        else if search.selectedScopeButtonIndex == 2
        {
            currentRecipes = db.read(queryStatement: "SELECT * FROM seafood;")
            recipeTable.reloadData()
        }
        else if search.selectedScopeButtonIndex == 3
        {
            currentRecipes = db.read(queryStatement: "SELECT * FROM dessert;")
            recipeTable.reloadData()
        }
    }
    
}




