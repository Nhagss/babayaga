//
//  Ingredient.swift
//  babayaga
//
//  Created by user on 24/04/25.
//

import Foundation
import SpriteKit

class Ingredient {
    let id: Int
    let nome: String
    let node: SKSpriteNode

    init(id: Int, nome: String, texture: SKTexture) {
        self.id = id
        self.nome = nome
        self.node = SKSpriteNode(texture: texture)
        self.node.size = CGSize(width: 30, height: 30)
        self.node.name = "Ingredient_\(id)"
    }
}
