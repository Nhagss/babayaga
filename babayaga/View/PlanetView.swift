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
    let worldBorder = SKShapeNode(circleOfRadius: 35)
    let playerAnchor = SKSpriteNode()
    let orbitAnchor = SKSpriteNode()
    let playerNode = PlayerView()
    var ingredients: [IngredientController] = []
    var objects: [ObjectView] = []
    
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
        
        world.addChild(worldBorder)
        worldBorder.fillColor = .clear
        worldBorder.strokeColor = .white
        worldBorder.glowWidth = 80
        worldBorder.zPosition = -10
        
        world.fillColor = .black
        world.strokeColor = .clear
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
    
    
    
    func addObject(angleInDegrees: CGFloat, withCollision: Bool = false, physicsCategory: UInt32 = PhysicsCategory.obstacle, texture: SKTexture? = nil, size: CGSize = CGSize(width: 50, height: 50), distanceToPlanet: CGFloat = 0) {
        let object = ObjectView(withCollision: withCollision, physicsCategory: physicsCategory, texture: texture, size: size)
        
        let radius = world.frame.width / 2 + size.height / 2.5 + distanceToPlanet
        let angleInRadians = angleInDegrees * .pi / 180
        
        let x = radius * cos(angleInRadians)
        let y = radius * sin(angleInRadians)
        
        object.position = CGPoint(x: x, y: y)
        object.zRotation = angleInRadians - orbitAnchor.zRotation - .pi / 2
        object.zPosition = -1
        orbitAnchor.addChild(object)
        objects.append(object)
    }
    
    func addIngredient(model: Ingredient, angleInDegrees: CGFloat, onCollect: @escaping () -> Void) {
        let ingredientController = IngredientController(model: model, onCollect: onCollect)
        let ingredientView = ingredientController.view
        
        let radius = world.frame.width / 2 + 20
        let angleInRadians = angleInDegrees * .pi / 180
        
        let x = radius * cos(angleInRadians)
        let y = radius * sin(angleInRadians)
        
        ingredientView.position = CGPoint(x: x, y: y)
        ingredientView.zRotation = angleInRadians - orbitAnchor.zRotation - .pi / 2
        
        orbitAnchor.addChild(ingredientView)
        ingredients.append(ingredientController)
    }
    
    func addEnemyBat(delayApparitions: Double) {
        let batAnchor = SKNode()
        let batView = SKSpriteNode(imageNamed: "enemy-bat")
        batView.size = CGSize(width: 50, height: 50)
        batAnchor.addChild(batView)
        batView.position = CGPoint(x: 0, y: 0)
        
        orbitAnchor.addChild(batAnchor)
        
        func animateBatCycle() {
            let pullUpAction = SKAction.move(by: CGVector(dx: 0, dy: world.frame.width), duration: 2)
            let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: 4)
            let hideAction = SKAction.move(by: CGVector(dx: 0, dy: -world.frame.width), duration: 2)
            
            batView.run(pullUpAction) {
                batAnchor.run(rotateAction) {
                    batView.run(hideAction) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + delayApparitions) {
                            animateBatCycle() // chama a função recusivamente para repetir
                        }
                        
                    }
                }
            }
        }
        
        animateBatCycle()
    }
    
    func rotateOrbitAnchor(angleInDegrees: CGFloat) {
        let angleInRadians = angleInDegrees * .pi / 180
        orbitAnchor.zRotation = angleInRadians
    }
}

#Preview() {
    GameViewController()
}
