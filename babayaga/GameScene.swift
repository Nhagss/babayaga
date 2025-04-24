//
//  GameScene.swift
//  POC_game
//
//  Created by Joao Roberto Fernandes Magalhaes on 12/04/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var personagem: SKSpriteNode!
    private var listLabel: SKLabelNode?
    private var collectedIngredients = 0
    private let totalIngredients = 8
    private var helloLabel: SKLabelNode?
    
    private var ingredientes: [Ingredient] = []
    private var pilha = PilhaDeIngredientes()
    private var spritesColetados: [SKSpriteNode] = []
    private let ordemCorreta = [8, 5, 4, 6, 3, 2, 7, 1]
    
    
    
    
    override func didMove(to view: SKView) {
        self.helloLabel = self.childNode(withName: "//helloLabel") as? SKLabelNode
        helloLabel?.alpha = 0.0
        helloLabel?.run(SKAction.fadeIn(withDuration: 2.0))
        
        self.listLabel = self.childNode(withName: "//listLabel") as? SKLabelNode
        listLabel?.alpha = 0.0
        listLabel?.run(SKAction.fadeIn(withDuration: 2.0))
        listLabel?.text = "Coletados: 0"
        setupPersonagem()
        spawnIngredients()
        mostrarOrdemCorretaVisual()
    }
    
    private func setupPersonagem() {
        let circle = SKShapeNode(circleOfRadius: 30)
        circle.fillColor = .purple
        circle.name = "Personagem"
        
        personagem = SKSpriteNode(color: .clear, size: CGSize(width: 2, height: 2))
        personagem.name = "Personagem"
        personagem.position = .zero
        personagem.zPosition = 1
        
        personagem.addChild(circle)
        addChild(personagem)
    }

    private func spawnIngredients() {
        let nomes = [
            (1, "Pó de fada"), (2, "Suor de globin"), (3, "Pena de corvo"),
            (4, "Água da lua cheia"), (5, "Escama de Dragão"), (6, "Mel de flores silvestres"),
            (7, "Sal negro do Himalaia"), (8, "Artemísia")
        ]
        
        for (id, nome) in nomes.shuffled() {
            let ingrediente = Ingredient(id: id, nome: nome, texture: SKTexture(imageNamed: "goldCoin\(id)"))
            ingrediente.node.position = randomPosition()
            ingrediente.node.name = "Ingredient_\(id)"
            
            ingredientes.append(ingrediente)
            addChild(ingrediente.node)
        }
    }

    //Para que o ingrediente nunca spawne onde o personagem começa
    private func randomPosition() -> CGPoint {
        var position: CGPoint
        let avoidZone = CGRect(x: -50, y: -50, width: 100, height: 100)
        repeat {
            let x = CGFloat.random(in: -250...250)
            let y = CGFloat.random(in: -250...250)
            position = CGPoint(x: x, y: y)
        } while avoidZone.contains(position)
        
        return position
    }

    
    private func mostrarOrdemCorretaVisual() {
        let spacing: CGFloat = 45
        let baseX = -(spacing * CGFloat(ordemCorreta.count - 1) / 2)
        let posY = size.height / 2 - 50
        
        for (index, id) in ordemCorreta.enumerated() {
            let sprite = SKSpriteNode(texture: SKTexture(imageNamed: "goldCoin\(id)"))
            sprite.setScale(0.4)
            sprite.position = CGPoint(x: baseX + spacing * CGFloat(index), y: posY)
            addChild(sprite)
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        personagem.position = location
    }
    
    override func update(_ currentTime: TimeInterval) {
        verificarColisoes()
    }
    
    
    private func verificarColisoes() {
        for ingrediente in ingredientes where ingrediente.node.parent != nil {
            if personagem.frame.intersects(ingrediente.node.frame) {
                processarIngrediente(ingrediente)
            }
        }
    }
    
    private func processarIngrediente(_ ingrediente: Ingredient) {
        _ = ingrediente.id
        
        guard ingrediente.node.parent != nil else { return }

        ingrediente.node.removeFromParent()
        pilha.empilhar(ingrediente)
        collectedIngredients += 1
        listLabel?.text = "Coletados: \(collectedIngredients)"
        
        mostrarIngredienteColetado(ingrediente)
        
        if pilha.quantidade == totalIngredients {
            if pilha.verificarSeCorreta(com: ordemCorreta) {
                listLabel?.text = "Parabéns! Ordem correta!"
            } else {
                listLabel?.text = "Ordem errada! Tente novamente."
            }
        }
    }


    //leo was here
    private func coletarIngrediente(_ ingrediente: Ingredient) {
        ingrediente.node.removeFromParent()
        pilha.empilhar(ingrediente)
        collectedIngredients += 1
        mostrarIngredienteColetado(ingrediente)
        
        if pilha.quantidade == totalIngredients {
            _ = pilha.verificarSeCorreta(com: ordemCorreta)
        }
    }
    
    private func mostrarIngredienteColetado(_ ingrediente: Ingredient) {
        let posX = CGFloat(pilha.quantidade - 1) * 45 - 160
        let posY = -size.height / 2 + 50
        let sprite = SKSpriteNode(texture: ingrediente.node.texture)
        
        sprite.position = CGPoint(x: posX, y: posY)
        sprite.setScale(0.4)
        spritesColetados.append(sprite)
        addChild(sprite)
    }
}
