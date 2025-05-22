//
//  PlayerView.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation
import SpriteKit
import SwiftUI
class PlayerView: SKNode {
    private let skin: CharacterSkin
    private let hitboxNode = SKShapeNode(rectOf: CGSize(width: 45, height: 40))
    
    init(skin: CharacterSkin) {
        self.skin = skin
        super.init()
        addChild(hitboxNode)
        
        hitboxNode.fillColor = .clear
        hitboxNode.strokeColor = .clear
        
        let character = createCharacter()
        addChild(character)
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var getChacterHitBox: SKShapeNode {
        return hitboxNode
    }
    
    func stopMovement() {
        removeAllActions()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 45, height: 40))
        physicsBody?.friction = 0
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.obstacle | PhysicsCategory.stair | PhysicsCategory.enemyBat
    }
    
    func jump() {
        let jumpUp = SKAction.moveBy(x: 0, y: 20, duration: 0.1)
        let jumpDown = SKAction.moveBy(x: 0, y: -20, duration: 0.1)
        let sequence = SKAction.sequence([jumpUp, .wait(forDuration: 0.1), jumpDown])
        run(sequence)
    }
    
    func createCharacter() -> SKNode {
        let center = SKNode()
        let assets = skin.imageAssets
        
        let torso = SKSpriteNode(texture: SKTexture(imageNamed: assets.torso))
        torso.run(bobbing())
        torso.run(rotation(byangle: 0.05))
        torso.position.y = 0
        center.addChild(torso)
        
        let head = SKSpriteNode(texture: SKTexture(imageNamed: assets.head))
        head.setScale(1 / 1.6)
        head.run(bobbing())
        head.run(rotation(byangle: 0.02))
        head.position = CGPoint(x: -15, y: 130)
        center.addChild(head)
        
        let frontArm = createAnimatedAnchor(image: assets.frontArm, angle1: 0.8, angle2: -0.8)
        let backArm = createAnimatedAnchor(image: assets.backArm, angle1: -0.8, angle2: 0.8)
        
        let frontFoot = createAnimatedAnchor(image: assets.foot, angle1: -0.3, angle2: 0.3)
        let backFoot = createAnimatedAnchor(image: assets.backFoot ?? assets.foot, angle1: 0.3, angle2: -0.3)
        
        frontFoot.position.y = 40
        backFoot.position.y = 40
        center.addChild(frontFoot)
        center.addChild(backFoot)
        
        // Posicionamento dos membros
        frontArm.children.first?.position = CGPoint(x: 10, y: -20)
        backArm.children.first?.position = CGPoint(x: -10, y: -20)
        center.addChild(backArm)
        center.addChild(frontArm)
        frontFoot.children.first?.position = CGPoint(x: 0, y: -80)
        backFoot.children.first?.position = CGPoint(x: 0, y: -80)
        
        // Escalas
        [frontFoot, backFoot].forEach {
            $0.children.first?.xScale = 1
            $0.children.first?.yScale = 1
        }
        
        [frontArm, backArm].forEach {
            $0.children.first?.xScale = 0.8
            $0.children.first?.yScale = 0.8
        }
        
        // Z Positions
        backArm.children.first?.zPosition = 0
        backFoot.children.first?.zPosition = 1
        frontFoot.children.first?.zPosition = 2
        torso.zPosition = 3
        frontArm.children.first?.zPosition = 4
        head.zPosition = 5
        
        // Escala total
        center.setScale(0.4)
        
        return center
    }
    
    func createAnimatedAnchor(image: String, angle1: CGFloat, angle2: CGFloat) -> SKNode {
        let anchor = SKNode()
        let sprite = SKSpriteNode(texture: SKTexture(imageNamed: image))
        anchor.addChild(sprite)
        
        let rotate1 = SKAction.rotate(toAngle: angle1, duration: 1, shortestUnitArc: true)
        let rotate2 = SKAction.rotate(toAngle: angle2, duration: 1, shortestUnitArc: true)
        let sequence = SKAction.sequence([rotate1, rotate2])
        anchor.run(SKAction.repeatForever(sequence))
        
        return anchor
    }
    
    func bobbing() -> SKAction {
        let up = SKAction.moveBy(x: 0, y: 5, duration: 0.5)
        let down = SKAction.moveBy(x: 0, y: -5, duration: 0.5)
        return SKAction.repeatForever(SKAction.sequence([up, down]))
    }
    
    func rotation(byangle: CGFloat) -> SKAction {
        let right = SKAction.rotate(byAngle: byangle, duration: 0.5)
        let left = SKAction.rotate(byAngle: -byangle, duration: 0.5)
        return SKAction.repeatForever(SKAction.sequence([right, left]))
    }
}

#Preview() {
    InitialScreen()
}
