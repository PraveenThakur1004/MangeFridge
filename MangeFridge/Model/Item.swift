//
//  Item.swift
//  MangeFridge
//
//  Created by MAC on 10/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import Foundation
//MARK- Section Data Structure
public struct Item {
    var name: String
    var duration: String
    var category: String
    var image:String
    var description:String
    var favoritestatus:String
    var ingredients:String
    var recipe:String
    var ratings:String
    public init(name: String, duration: String, category:String, image:String,description:String,favoritestatus:String,ingredients:String,recipe:String,ratings:String) {
        self.name = name
        self.duration = duration
        self.category = category
        self.image = image
        self.description = description
        self.favoritestatus = favoritestatus
        self.ingredients = ingredients
        self.recipe = recipe
        self.ratings = ratings
    }
}
