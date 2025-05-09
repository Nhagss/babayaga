//
//  IngredientView.swift
//  babayaga
//
//  Created by Honório Filho on 26/04/25.
//

import SpriteKit

class IngredientView: SKSpriteNode {
    
    init(model: Ingredient) {
        super.init(texture: SKTexture(imageNamed: "ingredient\(model.id)"), color: .clear, size: CGSize(width: 30, height: 30))
        
        self.name = model.name
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(circleOfRadius: size.height)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.ingredient
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
