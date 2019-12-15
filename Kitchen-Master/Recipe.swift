//
//  Recipe.swift
//  Kitchen-Master
//
//  Created by Zhihao Wang on 12/13/19.
//  Copyright © 2019 Zhihao Wang. All rights reserved.
//

import Foundation

class Recipe{
    var title: String
    var tag: String
    var ingredients: String
    var instruction: String
    
    
    init(title: String, tag:String, ingredients:String, instruction: String){
        self.title = title
        self.tag = tag
        self.ingredients = ingredients
        self.instruction = instruction
           
       }
    
}
