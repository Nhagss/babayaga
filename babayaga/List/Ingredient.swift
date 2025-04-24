//
//  Ingredient.swift
//  POC_game
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/04/25.
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
        self.node.size = CGSize(width: 70, height: 70)
        self.node.name = "Ingredient_\(id)"
    }
}
