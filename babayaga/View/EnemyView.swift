//
//  EnemyView.swift
//  babayaga
//
//  Created by Yago Souza Ramos on 5/20/25.
//

import SpriteKit

class EnemyBatView: SKNode {
    let sprite: SKSpriteNode
    let warning: SKSpriteNode
    
    init(textureName: String, warningImage: String = "bat-warning", scale: CGFloat = 0.45) {
        self.sprite = SKSpriteNode(imageNamed: textureName)
        self.warning = SKSpriteNode(imageNamed: warningImage)
        super.init()
        
        sprite.yScale = scale
        sprite.zPosition = -100
        sprite.position = CGPoint(x: 0, y: -10)
        addChild(sprite)
        
        warning.yScale = 0.2
        warning.xScale = 0.2
        warning.position = CGPoint(x: 0, y: 150) // assuming world.frame.width / 1.3 ~ 160
        warning.zPosition = -100
        addChild(warning)
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        sprite.physicsBody?.friction = 0
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.usesPreciseCollisionDetection = true
        
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.enemyBat
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.none
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.player
    }

    
    func startHovering() {
        let flyUp = SKAction.move(by: CGVector(dx: 0, dy: 10), duration: 0.2)
        let flyDown = SKAction.move(by: CGVector(dx: 0, dy: -10), duration: 0.3)
        flyUp.timingMode = .easeOut
        flyDown.timingMode = .easeOut
        let sequenceFly = SKAction.sequence([flyUp, flyDown])
        let flyRepeat = SKAction.repeatForever(sequenceFly)
        flyRepeat.timingMode = .easeOut
        sprite.run(flyRepeat)
    }
    
    func showWarning() {
        warning.isHidden = false
    }
    
    func hideWarning() {
        warning.isHidden = true
    }
}

#Preview() {
    GameViewController()
}
