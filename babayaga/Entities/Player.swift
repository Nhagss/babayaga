//
//  Player.swift
//  babayaga
//
//  Created by user on 24/04/25.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {

    private static let playerSize = CGSize(width: 30, height: 40)
    private static let playerColor = UIColor.white
    private static let initialRelativeY: CGFloat = 120
    
    init() {

        super.init(texture: nil, color: Player.playerColor, size: Player.playerSize)

        /// Posição relativa ao playerAnchor)
        self.position = CGPoint(x: 0, y: Player.initialRelativeY)

        /// Corpo Físico
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false

        /// Categoria
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func performJump() {
        
        // Verifica se a ação já está rodando em 'self'
        if self.action(forKey: "playerJump") != nil {
            return
        }

        let jumpUpAction = SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0.1)
        jumpUpAction.timingMode = .easeOut
        let fallDownAction = SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 0.1)
        fallDownAction.timingMode = .easeIn
        let waitAction = SKAction.wait(forDuration: 0.1)
        let jumpSequence = SKAction.sequence([jumpUpAction, waitAction, fallDownAction])
        
        self.run(jumpSequence, withKey: "playerJump")
    }
}
