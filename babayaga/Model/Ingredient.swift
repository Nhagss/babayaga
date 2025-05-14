//
//  Ingredient.swift
//  babayaga
//
//  Created by user on 24/04/25.
//

import Foundation
import SpriteKit

@Observable
class Ingredient {
    let id: Int
    let name: String
    var total: Int
    var remaining: Int
    
    init(id: Int, name: String, total: Int) {
        self.id = id
        self.name = name
        self.total = total
        self.remaining = total
    }
}
