//
//  PlanetView.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation
import SpriteKit

class PlanetView: SKNode {
    let positioner = SKSpriteNode()
    let world = SKShapeNode(circleOfRadius: 100)
    let playerAnchor = SKSpriteNode()
    let playerNode = PlayerView()

    override init() {
        super.init()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addChild(positioner)
        positioner.addChild(world)
        positioner.addChild(playerAnchor)
        playerAnchor.addChild(playerNode)

        world.fillColor = .black
        world.position = .zero

        playerAnchor.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        playerAnchor.physicsBody?.isDynamic = true
        playerAnchor.physicsBody?.friction = 0
        playerAnchor.physicsBody?.affectedByGravity = false
        playerAnchor.physicsBody?.allowsRotation = true

        playerNode.position = CGPoint(x: 0, y: 120)
    }

    func rotate(speed: CGFloat) {
        playerAnchor.removeAction(forKey: "rotation")
        let rotateAction = SKAction.rotate(byAngle: speed, duration: 1)
        let repeatAction = SKAction.repeatForever(rotateAction)
        playerAnchor.run(repeatAction, withKey: "rotation")
    }

    func stopRotation() {
        playerAnchor.removeAction(forKey: "rotation")
    }
}

