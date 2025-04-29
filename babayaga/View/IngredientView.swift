//
//  IngredientView.swift
//  babayaga
//
//  Created by Honório Filho on 26/04/25.
//

import SpriteKit

class IngredientView: SKSpriteNode {
    
    init(model: Ingredient) {
        super.init(texture: SKTexture(imageNamed: "goldCoin\(model.id)"), color: .clear, size: CGSize(width: 30, height: 30))
        self.name = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
