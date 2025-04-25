//
//  PlayerView.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation
import SpriteKit

class PlayerView: SKSpriteNode {
    init() {
        let size = CGSize(width: 30, height: 40)
        super.init(texture: nil, color: .white, size: size)
        setupPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 0
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.stairs
        physicsBody?.collisionBitMask = 0
    }

    func jump() {
        let jumpUp = SKAction.moveBy(x: 0, y: 20, duration: 0.1)
        let jumpDown = SKAction.moveBy(x: 0, y: -20, duration: 0.1)
        let sequence = SKAction.sequence([jumpUp, .wait(forDuration: 0.1), jumpDown])
        run(sequence)
    }
}

