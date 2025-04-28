//
//  ObstacleView.swift
//  babayaga
//
//  Created by Honório Filho on 26/04/25.
//

import Foundation
import SpriteKit

class ObstacleView: SKSpriteNode {
    
    init() {
        let size = CGSize(width: 50, height: 50)
        super.init(texture: nil, color: .systemYellow, size: size)
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        
        physicsBody?.friction = 0
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
