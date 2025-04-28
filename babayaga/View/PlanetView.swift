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
    let orbitAnchor = SKSpriteNode()
    let playerNode = PlayerView()
    var ingredients: [IngredientView] = []
    var obstacles: [ObstacleView] = []
    
    var gravityField = SKFieldNode.radialGravityField()

    override init() {
        super.init()
        setupView()
        rotateOrbitAnchor(angleInDegrees: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addChild(positioner)
        positioner.addChild(world)
        positioner.addChild(orbitAnchor)
        orbitAnchor.addChild(playerAnchor)
        playerAnchor.addChild(playerNode)
        
        world.fillColor = .systemOrange
        positioner.position = .zero
                
        playerAnchor.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        playerAnchor.physicsBody?.isDynamic = false
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
    
    func addObstacle(angleInDegrees: CGFloat) {
        let obstacle = ObstacleView()
        
        let radius = world.frame.width / 2 + 20
        let angleInRadians = angleInDegrees * .pi / 180
        
        let x = radius * cos(angleInRadians)
        let y = radius * sin(angleInRadians)
        
        obstacle.position = CGPoint(x: x, y: y)
        obstacle.zRotation = angleInRadians - orbitAnchor.zRotation - .pi / 2

        orbitAnchor.addChild(obstacle)
        obstacles.append(obstacle)
    }
    
    func addIngredient(model: Ingredient, angleInDegrees: CGFloat) {
        let ingredient = IngredientView(model: model)
        
        let radius = world.frame.width / 2 + 20
        let angleInRadians = angleInDegrees * .pi / 180
        
        let x = radius * cos(angleInRadians)
        let y = radius * sin(angleInRadians)
        
        ingredient.position = CGPoint(x: x, y: y)
        ingredient.zRotation = angleInRadians - orbitAnchor.zRotation - .pi / 2

        orbitAnchor.addChild(ingredient)
        ingredients.append(ingredient)
    }
    
    func rotateOrbitAnchor(angleInDegrees: CGFloat) {
        let angleInRadians = angleInDegrees * .pi / 180
        orbitAnchor.zRotation = angleInRadians
    }
}

