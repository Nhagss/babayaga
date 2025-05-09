//
//  ObstacleView.swift
//  babayaga
//
//  Created by Honório Filho on 26/04/25.
//

import Foundation
import SpriteKit

class ObjectView: SKSpriteNode {
    
    init(withCollision: Bool, isHouse: Bool = false, texture: SKTexture?, size: CGSize) {
        let size = size
        super.init(texture: texture, color: .systemYellow, size: size)
        if (withCollision) {
            setupPhysics(isHouse: isHouse)
        }
    }
    
    private func setupPhysics(isHouse: Bool) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        
        physicsBody?.friction = 0
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask = isHouse ? PhysicsCategory.house : PhysicsCategory.obstacle
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
