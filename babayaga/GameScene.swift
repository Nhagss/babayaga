//
//  GameScene.swift
//  babayaga
//
//  Created by Yago Souza Ramos on 4/22/25.
//

import SpriteKit
import GameplayKit

//Definir a física do personagem e do obstaculo
struct PhysicsCategory {
    static let character: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var mainCharacter: SKSpriteNode!
    var obstacle: SKShapeNode!
    var lives = 3
    var livesLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    var restartButton: SKLabelNode!
    var isGameOver = false
    var isHit = false

    //Setup inicial da fase
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        backgroundColor = .black
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        // Vidas
        lives = 3
        livesLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        livesLabel.fontSize = 30
        livesLabel.fontColor = .white
        livesLabel.position = CGPoint(x: size.width - 80, y: size.height - 50)
        livesLabel.text = "Vidas: \(lives)"
        addChild(livesLabel)

        // Personagem
        mainCharacter = SKSpriteNode(imageNamed: "spritedois")
        mainCharacter.position = CGPoint(x: size.width / 2 - 130, y: size.height / 2 + 5)
        mainCharacter.name = "runner"
        addChild(mainCharacter)

        mainCharacter.physicsBody = SKPhysicsBody(texture: mainCharacter.texture!, size: mainCharacter.size)
        mainCharacter.physicsBody?.isDynamic = true
        mainCharacter.physicsBody?.categoryBitMask = PhysicsCategory.character
        mainCharacter.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        mainCharacter.physicsBody?.collisionBitMask = PhysicsCategory.obstacle
        mainCharacter.physicsBody?.affectedByGravity = false
        mainCharacter.physicsBody?.allowsRotation = false

        // Obstáculo
        obstacle = SKShapeNode(rectOf: CGSize(width: 60, height: 60), cornerRadius: 8)
        obstacle.fillColor = .blue
        obstacle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        obstacle.name = "obstacle"
        addChild(obstacle)

        obstacle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: 60))
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.character
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.character

        addBounceAnimation()
        startRunning()
    }
    
    //Animação de boucing
    func addBounceAnimation() {
        mainCharacter.removeAction(forKey: "bounce")

        let bounceUp = SKAction.group([
            SKAction.moveBy(x: 0, y: 6, duration: 0.07),
            SKAction.scaleX(to: 0.95, duration: 0.07),
            SKAction.scaleY(to: 1.05, duration: 0.07)
        ])
        let bounceDown = SKAction.group([
            SKAction.moveBy(x: 0, y: -6, duration: 0.07),
            SKAction.scaleX(to: 1.05, duration: 0.07),
            SKAction.scaleY(to: 0.95, duration: 0.07)
        ])
        let resetScale = SKAction.group([
            SKAction.scaleX(to: 1.0, duration: 0.03),
            SKAction.scaleY(to: 1.0, duration: 0.03)
        ])
        let bounce = SKAction.sequence([bounceUp, bounceDown, resetScale])
        mainCharacter.run(SKAction.repeatForever(bounce), withKey: "bounce")
    }
    
    //Mover o personagem
    func startRunning() {
        mainCharacter.removeAction(forKey: "run")
        let move = SKAction.moveBy(x: 2, y: 0, duration: 0.01)
        let moveForever = SKAction.repeatForever(move)
        mainCharacter.run(moveForever, withKey: "run")
    }

    //Colisão
    func didBegin(_ contact: SKPhysicsContact) {
        if isGameOver || isHit { return }

        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategory.character | PhysicsCategory.obstacle {
            isHit = true
            mainCharacter.removeAction(forKey: "run")

            let spin = SKAction.rotate(byAngle: -.pi * 2, duration: 0.4)
            let moveBack = SKAction.move(to: CGPoint(x: size.width / 2 - 130, y: size.height / 2 + 5), duration: 0.2)

            let afterSpin = SKAction.run {
                self.lives -= 1
                self.livesLabel.text = "Vidas: \(self.lives)"

                if self.lives <= 0 {
                    self.triggerGameOver()
                } else {
                    self.mainCharacter.zRotation = 0
                    self.isHit = false
                    self.startRunning()
                }
            }

            let sequence = SKAction.sequence([spin, moveBack, afterSpin])
            mainCharacter.run(sequence)
        }
    }

    //Game over
    func triggerGameOver() {
        isGameOver = true
        mainCharacter.removeAllActions()

        gameOverLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = .white
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height - 150)
        addChild(gameOverLabel)

        restartButton = SKLabelNode(fontNamed: "AvenirNext-Bold")
        restartButton.text = "Reiniciar"
        restartButton.fontSize = 40
        restartButton.fontColor = .red
        restartButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        restartButton.name = "restart"
        addChild(restartButton)
    }

    //Restart do jogo
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if touchedNode.name == "restart" {
            restartGame()
        }
    }

    func restartGame() {
        isGameOver = false
        isHit = false
        lives = 3
        livesLabel.text = "Vidas: \(lives)"

        gameOverLabel?.removeFromParent()
        restartButton?.removeFromParent()

        mainCharacter.position = CGPoint(x: size.width / 2 - 130, y: size.height / 2 + 5)
        mainCharacter.zRotation = 0

        addBounceAnimation()
        startRunning()
    }
}
