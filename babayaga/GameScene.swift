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
        
        let ingredientesDisponiveis = [
            (1, "Pó de fada"), (2, "Suor de goblin"), (3, "Pena de corvo"),
            (4, "Água da lua cheia")
        ]
        
        // Exemplo: adicionar 2 ingredientes no planeta 0
        for (id, name) in ingredientesDisponiveis.shuffled().prefix(4) {
            let ingrediente = Ingredient(id: id, name: name)
            planetControllers[0].view.addIngredient(model: ingrediente, angleInDegrees: CGFloat.random(in: 0...360))
            planetControllers[1].view.addIngredient(model: ingrediente, angleInDegrees: CGFloat.random(in: 0...360))
            planetControllers[2].view.addIngredient(model: ingrediente, angleInDegrees: CGFloat.random(in: 0...360))
        }
        
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
        planet2.view.position = CGPoint(x: -250, y: 150)
        planet3.view.position = CGPoint(x: 150, y: 400)
        
        planetControllers = [planet1, planet2, planet3]
        
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        planetControllers[0].addHouse(angleInDegrees: 90)
        planetControllers[1].makePlanetType(type: .complete)
        planetControllers[2].makePlanetType(type: .twoGrass)
        planetControllers[0].makePlanetType(type: .threeGrass)
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
            if player.getChacterHitBox.intersects(stair.view) {
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
    
    private func handleIngredientContact(_ contact: SKPhysicsContact) {
        let bodies = [contact.bodyA, contact.bodyB]
        
        /// Procura quem é o ingrediente na colisão
        if let ingredienteNode = bodies.first(where: { $0.categoryBitMask == PhysicsCategory.ingredient })?.node {
            
            /// Aqui vamos procurar em qual planeta o ingrediente está
            let planet = planetControllers[currentPlanetIndex]
            
            if let ingredient = planet.view.ingredients.first(where: { $0.view == ingredienteNode }) {
                processCollectedIngredient(ingredient, on: planet)
            }
        }
    }
    
    private func processCollectedIngredient(_ ingredient: IngredientController, on planet: PlanetController) {
        guard ingredient.view.parent != nil else { return }
        
        // Remove o ingrediente da cena
        ingredient.view.removeFromParent()
        
        // Remove da lista de ingredientes ativos no planeta
        if let index = planet.view.ingredients.firstIndex(where: { $0 === ingredient }) {
            planet.view.ingredients.remove(at: index)
        }
        
        // Aqui você pode guardar o ingrediente coletado num inventário futuro
        print("Ingrediente coletado: \(ingredient.model.name)")
    }
    
    private func showHouseMessage(at position: CGPoint, text: String) {
        let multilineLabel = createMultilineLabel(text: text, maxWidth: 200, fontSize: 16, fontName: "AvenirNext-Bold", fontColor: .white)
        
        let labelSize = multilineLabel.calculateAccumulatedFrame().size
        let padding: CGFloat = 10
        let bubbleSize = CGSize(width: labelSize.width + padding * 2, height: labelSize.height + padding * 2)
        let bubbleRect = CGRect(origin: CGPoint(x: -bubbleSize.width / 2, y: -bubbleSize.height / 2), size: bubbleSize)
        
        let radius: CGFloat = 20
        let minX = bubbleRect.minX
        let minY = bubbleRect.minY
        let maxX = bubbleRect.maxX
        let maxY = bubbleRect.maxY
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: minX, y: minY-10))
        path.addLine(to: CGPoint(x: minX + 10, y: minY))
        path.addLine(to: CGPoint(x: maxX - radius, y: minY))
        path.addQuadCurve(to: CGPoint(x: maxX, y: minY + radius), control: CGPoint(x: maxX, y: minY))
        path.addLine(to: CGPoint(x: maxX, y: maxY - radius))
        path.addQuadCurve(to: CGPoint(x: maxX - radius, y: maxY), control: CGPoint(x: maxX, y: maxY))
        path.addLine(to: CGPoint(x: minX + radius, y: maxY))
        path.addQuadCurve(to: CGPoint(x: minX, y: maxY - radius), control: CGPoint(x: minX, y: maxY))
        path.addLine(to: CGPoint(x: minX, y: minY))
        path.closeSubpath()
        
        let bubbleNode = SKShapeNode(path: path)
        bubbleNode.fillColor = .black
        bubbleNode.lineWidth = 2
        
        bubbleNode.addChild(multilineLabel)
        let labelFrame = multilineLabel.calculateAccumulatedFrame()
        multilineLabel.position = CGPoint(x: 0, y: labelFrame.height / 2 - 10)
        
        bubbleNode.position = position
        self.addChild(bubbleNode)
        
        let wait = SKAction.wait(forDuration: 2.0)
        let remove = SKAction.removeFromParent()
        bubbleNode.run(SKAction.sequence([wait, remove]))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        if contactBetween(contact, PhysicsCategory.player, PhysicsCategory.obstacle) {
            print("Player colidiu com obstáculo!")
            planetControllers[currentPlanetIndex].reverseRotation()
        }
        
        if contactBetween(contact, PhysicsCategory.player, PhysicsCategory.house) {
            let xPos = contact.bodyB.node!.position.x + 100
            let yPos = contact.bodyB.node!.position.y - 30
            let position = CGPoint(x: xPos, y: yPos)
            
            showHouseMessage(at: position, text: "You still dont have all the ingredients!")
        }
        
        if contactBetween(contact, PhysicsCategory.player, PhysicsCategory.ingredient) {
            print("contato ingrediente")
            handleIngredientContact(contact)
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

func createMultilineLabel(text: String, maxWidth: CGFloat, fontSize: CGFloat, fontName: String, fontColor: SKColor) -> SKNode {
    let words = text.split(separator: " ")
    var lines: [String] = []
    var currentLine = ""
    
    let tempLabel = SKLabelNode(fontNamed: fontName)
    tempLabel.fontSize = fontSize
    
    for word in words {
        let testLine = currentLine.isEmpty ? String(word) : "\(currentLine) \(word)"
        tempLabel.text = testLine
        if tempLabel.frame.width > maxWidth {
            lines.append(currentLine)
            currentLine = String(word)
        } else {
            currentLine = testLine
        }
    }
    lines.append(currentLine)
    
    let parentNode = SKNode()
    for (i, line) in lines.enumerated() {
        let label = SKLabelNode(text: line)
        label.fontName = fontName
        label.fontSize = fontSize
        label.fontName = "HelveticaNeue-Bold"
        label.fontColor = fontColor
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: CGFloat(-i) * (fontSize + 4))
        parentNode.addChild(label)
    }
    
    return parentNode
}
