//
//  GameScene.swift
//  babayaga
//
//  Created by Yago Souza Ramos on 4/22/25.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene {
    var planets: [Planet] = []
    var currentPlanetIndex = 0
    var gameWorld = SKNode()
    var cameraNode = SKCameraNode()
    var stairs: [SKShapeNode] = []
    
    override func didMove(to view: SKView) {
        
        camera = cameraNode
        addChild(cameraNode)
        
        gameWorld.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameWorld)
        
        let planet = PlanetController()
        let planet2 = PlanetController()
        let planet3 = PlanetController()
        
        planet.view.position = CGPoint(x: 0, y: 10)
        planet2.view.position = CGPoint(x: -100, y: -400)
        planet3.view.position = CGPoint(x: -300, y: -600)
        
        gameWorld.addChild(planet.view)
        gameWorld.addChild(planet2.view)
        gameWorld.addChild(planet3.view)
        planet.startRotation()
    }
    
    private func setupWorld() {
        camera = cameraNode
        addChild(cameraNode)
        
        gameWorld.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameWorld)
    }
    
    //    override func didMove(to view: SKView) {
    //        camera = cameraNode
    //        addChild(cameraNode)
    //        gameWorld.position = CGPoint(x: frame.midX, y: frame.midY)
    //        addChild(gameWorld)
    //
    //        planets.append(Planet())
    //        planets.append(Planet())
    //        planets.append(Planet())
    //
    //        physicsWorld.contactDelegate = self
    //
    //        let spacing: CGFloat = 300
    //        for i in 0..<planets.count {
    //
    //            makePlanet(p: planets[i], gameWorld: gameWorld)
    //            let path = CGMutablePath()
    //            let planetY = CGFloat(i) * spacing
    //            planets[i].positioner.position = CGPoint(x: 0, y: planetY)
    //            if i > 0 {
    //
    //                let from = planets[0].playerAnchor.convert(CGPoint.zero, to: gameWorld)
    //                let to = planets[i].playerAnchor.convert(CGPoint.zero, to: gameWorld)
    //
    //                path.move(to: from)
    //
    //                path.addLine(to: to)
    //
    //                let line = SKShapeNode(path: path)
    //                line.strokeColor = .gray
    //                line.alpha = 0.7
    //                line.lineWidth = 30
    //                line.zPosition = -10
    //
    //                // Só visual, sem física agora
    //                gameWorld.addChild(line)
    //
    //                // Guarda no array para checar no update
    //                stairs.append(line)
    //            }
    //
    //            planets[i].positioner.position = CGPoint(x: 0, y: CGFloat(i) * spacing)
    //
    //        }
    //
    //        cameraNode.position = CGPoint(x: planets[0].positioner.position.x + (scene?.bounds.width ?? 0)/2, y: planets[0].positioner.position.y + (scene?.bounds.height ?? 0)/2)
    //
    //        // Roda o mundo
    //        let angleInDegrees: CGFloat = 0
    //        let angleInRadians = angleInDegrees * .pi / 180
    //        gameWorld.zRotation = angleInRadians
    //
    //
    //    }
    //
    //    override func update(_ currentTime: TimeInterval) {
    //        let player = planets[currentPlanetIndex].player
    //
    //        var isTouchingStair = false
    //
    //        for stair in stairs {
    //            if player!.intersects(stair) {
    //                isTouchingStair = true
    //                break
    //            }
    //        }
    //
    //        if isTouchingStair && !planets[currentPlanetIndex].isContactingStair {
    //            planets[currentPlanetIndex].isContactingStair = true
    //            planets[currentPlanetIndex].slowDownRotation()
    //        } else if !isTouchingStair && planets[currentPlanetIndex].isContactingStair {
    //            planets[currentPlanetIndex].isContactingStair = false
    //            planets[currentPlanetIndex].regularRotation()
    //        }
    //    }
    //
    //
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        guard let touch = touches.first else { return }
    //        let location = touch.location(in: self)
    //        let nodesAtPoint = nodes(at: location)
    //
    //        for _ in nodesAtPoint {
    //        }
    //    }
    //
    //    //Creates on the current parent
    //    func makePlanet(p: Planet, isCurrent: Bool = false, gameWorld: SKNode) -> Void {
    //        // Coloca o positioner no centro da cena
    //        p.positioner = SKSpriteNode()
    //        //        p.positioner.position = CGPoint(x: frame.midX, y: frame.midY)
    //        gameWorld.addChild(p.positioner)
    //
    //        // Mundo (no centro do positioner)
    //        p.world = SKShapeNode(circleOfRadius: 100)
    //        p.world.position = .zero  // porque já tá no centro via positioner
    //        p.world.fillColor = .black
    //        p.positioner.addChild(p.world)
    //
    //        // Âncora (também no centro do positioner)
    //        p.playerAnchor = SKSpriteNode()
    //        p.playerAnchor.physicsBody = SKPhysicsBody(circleOfRadius: 100)
    //        p.playerAnchor.physicsBody?.isDynamic = true
    //        p.playerAnchor.physicsBody?.friction = 0
    //        p.playerAnchor.physicsBody?.affectedByGravity = false
    //        p.playerAnchor.physicsBody?.allowsRotation = true
    //        p.playerAnchor.position = .zero
    //
    //        p.positioner.addChild(p.playerAnchor)
    //
    //        p.player = Player()
    //
    //        p.playerAnchor.addChild(p.player)
    //
    //        p.ingredient = Ingredient(id: 1, nome: "Pó de fada", texture: SKTexture(imageNamed: "goldCoin1"))
    //
    //        p.ingredient.node.position = CGPoint(x: 0, y: 120)
    //
    //        p.playerAnchor.addChild(p.ingredient.node)
    //    }
    //
    //    func changeDirection(planet: Planet) -> Void {
    //        planet.changeDirection()
    //    }
    //
    //    func jumpOrChangePlanet() {
    //        if(planets[currentPlanetIndex].isContactingStair) {
    //            planets[currentPlanetIndex].isContactingStair = false
    //            // Hide current player
    //            planets[currentPlanetIndex].pauseRotation()
    //            //planets[currentPlanetIndex].player.isHidden = true
    //            // Update index
    //            currentPlanetIndex = (currentPlanetIndex + 1) % planets.count
    //
    //            // Show new one
    //            planets[currentPlanetIndex].unPauseRotation()
    //            //planets[currentPlanetIndex].player.isHidden = false
    //
    //            moveCameraToCurrentPlanet()
    //        } else {
    //            planets[currentPlanetIndex].jump()
    //        }
    //    }
    //
    //    func moveCameraToCurrentPlanet() {
    //        let planet = planets[currentPlanetIndex]
    //        let newPosition = CGPoint(
    //            x: planet.positioner.position.x + (scene?.size.width ?? 0) / 2,
    //            y: planet.positioner.position.y + (scene?.size.height ?? 0) / 2
    //        )
    //
    //        let moveAction = SKAction.move(to: newPosition, duration: 0.5)
    //        moveAction.timingMode = .easeOut
    //        camera?.run(moveAction)
    //    }
    
}

//extension GameScene: SKPhysicsContactDelegate {
//    func contactBetween(_ contact: SKPhysicsContact, _ a: UInt32, _ b: UInt32) -> Bool {
//        let set = Set([contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask])
//        return set == Set([a, b])
//    }
//}

#Preview {
    GameViewController()
}
