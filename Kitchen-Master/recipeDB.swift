//
//  recipeDB.swift
//  Kitchen-Master
//
//  Created by Zhihao Wang on 12/14/19.
//  Copyright © 2019 Zhihao Wang. All rights reserved.
//

import SQLite3
import Foundation

class RecipeDB{
    init()
    {
        db = openDatabase()
        createTable()
        
    }
    
    
    let dbpath: String = "/Users/zhihaowang/Desktop/kitchen.db"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = dbpath
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database")
            return db
            
        }
        
    }
    
    
    func createTable()
    {
        let createTableString = "CREATE TABLE IF NOT EXISTS meat(title TEXT PRIMARY KEY,ingredients TEXT,tag TEXT, instruction Text);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
                {
                    print("meat table created.")
                } else {
                    print("meat table could not be created.")
                }
        } else {
                print("CREATE TABLE statement could not be prepared.")
            }
            sqlite3_finalize(createTableStatement)
    
    }
    
    func read(queryStatement: String) -> [Recipe]{
        let queryStatementString = queryStatement
        var queryStatement: OpaquePointer? = nil
        var psns : [Recipe] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let tag = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let ingredients = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let instruction = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                psns.append(Recipe(title: title, tag: tag, ingredients: ingredients, instruction: instruction))
                //print("Query Result:")
                //print("\(title) | \(tag) | \(ingredients) | \(instruction)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
    
    /*
    static let instance = RecipeDB()
    let db:Connection?
    
    let recipes = Table("recipetest")
    let title = Expression<String>("title")
    let ingredients = Expression<String>("ingredients")
    let tag = Expression<String>("tag")
    let instruction = Expression<String>("instruction")
    
    
    
    private init(){
        
        do {
            db = try Connection("/Users/zhihaowang/Desktop/kitchen.db")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
       
    }
    */
    /*
    
    func createTable() {
        do {
            try db!.run(recipes.create(ifNotExists: true) { table in
            table.column(title, primaryKey: true)
            table.column(ingredients)
            table.column(tag)
            table.column(instruction)
            }
 )
        let query = recipes.filter(title == "beef")
            for recipe in try (db?.prepare(query))! {
     print("title: \(recipes[title])")
 }
        } catch {
            print("Unable to create table")
        }
    }
    
    
    func getRecipes() -> [Recipe] {
        
        var recipes = [Recipe]()

        do {
            for recipe in try db!.prepare(self.recipes) {
                recipes.append(Recipe(
                title: recipe[title], tag: recipe[tag], ingredients: recipe[ingredients], instruction: recipe[instruction]))
            }
        } catch {
            print("Select failed")
        }

        return recipes
    }
 
    */

