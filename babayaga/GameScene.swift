import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene {
    
    var currentPlanetIndex = 0
    var gameWorld = SKNode()
    var cameraNode = SKCameraNode()
    var planetControllers: [PlanetController] = []
    var nextPlanetID: UUID = UUID()
    private var stairControllers: [StairController] = []
    
    override func didMove(to view: SKView) {
        
        setupCamera()
        setupWorld()
        setupPlanets()
        setupStairs()
        
        physicsWorld.contactDelegate = self
        
        let poDeFada = Ingredient(id: 1, name: "Pó de fada")
        planetControllers[0].view.addIngredient(model: poDeFada, angleInDegrees: 0)
        

        planetControllers[0].addObstacle(angleInDegrees: 90)
        planetControllers[2].addObstacle(angleInDegrees: 90)

        /// Iniciar rotação do primeiro planeta
        planetControllers[0].startRotation()
    }
    
    private func setupCamera() {
        camera = cameraNode
        addChild(cameraNode)
    }
    
    private func setupWorld() {
        addChild(gameWorld)
        gameWorld.position = CGPoint(x: frame.minX, y: frame.minY)
    }
    
    private func setupPlanets() {
        let planet1 = PlanetController()
        let planet2 = PlanetController(parent: planet1)
        let planet3 = PlanetController(parent: planet2)
        
        planet1.view.position = CGPoint(x: 50, y: -150)
        planet2.view.position = CGPoint(x: -150, y: 200)
        planet3.view.position = CGPoint(x: 150, y: 400)

        planetControllers = [planet1, planet2, planet3]

        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
    }
    
    private func setupStairs() {
        guard planetControllers.count >= 2 else { return }
        
        for i in 1..<(planetControllers.count) {
            let start = planetControllers[i].view.position
            let end = planetControllers[i].parent?.view.position ?? planetControllers[i].view.position
            
            let stair = StairController(from: planetControllers[i], to: planetControllers[i].parent ?? planetControllers[i])
            
            stairControllers.append(stair)
            gameWorld.addChild(stair.view)
        }
    }
    
    func changePlanet() {
        if(planetControllers[currentPlanetIndex].isContactingStair) {
            planetControllers[currentPlanetIndex].isContactingStair = false
            
            /// Pause a rotação do planeta atual
            planetControllers[currentPlanetIndex].stopRotation()
            
            /// Oculta o player
            planetControllers[currentPlanetIndex].view.playerNode.isHidden = true
            
            /// Atualiza o index do array de planetas
            for i in 0..<planetControllers.count {
                if(planetControllers[i].id == nextPlanetID) {
                    currentPlanetIndex = i
                    print(i)
                    print(nextPlanetID)
                }
            }
            
            /// Retorna a animação, agora sendo de outro planeta
            planetControllers[currentPlanetIndex].startRotation()
            
            /// Mostra o player do atual planeta
            planetControllers[currentPlanetIndex].view.playerNode.isHidden = false
        }
    }
    
    func contactBetween(_ contact: SKPhysicsContact, _ a: UInt32, _ b: UInt32) -> Bool {
        let set = Set([contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask])
        return set == Set([a, b])
    }
    
    override func update(_ currentTime: TimeInterval) {
        let player = planetControllers[currentPlanetIndex].view.playerNode
        
        var isTouchingStair = false
        
        for stair in stairControllers {
            if player.intersects(stair.view) {
                isTouchingStair = true
                
                // Só atualiza o próximo planeta se ainda não estava na escada
                if !planetControllers[currentPlanetIndex].isContactingStair {
                    nextPlanetID = stair.getJumpDestination(currentPlanet: planetControllers[currentPlanetIndex].id)
                    print("Novo nextPlanetID definido:", nextPlanetID)
                }
                break
            }
        }
        
        if isTouchingStair && !planetControllers[currentPlanetIndex].isContactingStair {
            planetControllers[currentPlanetIndex].isContactingStair = true
            planetControllers[currentPlanetIndex].slowDownRotation()

        } else if !isTouchingStair && planetControllers[currentPlanetIndex].isContactingStair {
            planetControllers[currentPlanetIndex].isContactingStair = false
            planetControllers[currentPlanetIndex].startRotation()
        }
        
        /// Move a câmera suavemente para o planeta atual
        let targetPosition = CGPoint(
            x: planetControllers[currentPlanetIndex].view.position.x,
            y: planetControllers[currentPlanetIndex].view.position.y
        )
        
        /// Quanto mais perto de 1.0, mais rápido a câmera segue
        let lerpFactor: CGFloat = 0.1
        
        let newPosition = CGPoint(
            x: cameraNode.position.x + (targetPosition.x - cameraNode.position.x) * lerpFactor,
            y: cameraNode.position.y + (targetPosition.y - cameraNode.position.y) * lerpFactor
        )
        
        cameraNode.position = newPosition
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contactBetween(contact, PhysicsCategory.player, PhysicsCategory.obstacle) {
            print("Player colidiu com obstáculo!")
            planetControllers[currentPlanetIndex].reverseRotation()
        }
        
        
//        if contactBetween(contact, PhysicsCategory.player, PhysicsCategory.stair) {
//            print("Player tocou na escada!")
//            planetControllers[currentPlanetIndex].isContactingStair = true
//            planetControllers[currentPlanetIndex].slowDownRotation()
//        }
    }
    
//    func didEnd(_ contact: SKPhysicsContact) {
//        if contactBetween(contact, PhysicsCategory.player, PhysicsCategory.stair) {
//            print("Player saiu da escada!")
//            planetControllers[currentPlanetIndex].isContactingStair = false
//            planetControllers[currentPlanetIndex].startRotation()
//        }
//    }
    
}

#Preview {
    GameViewController()
}
