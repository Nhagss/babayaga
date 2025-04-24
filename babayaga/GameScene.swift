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
    
    private var ingredientes: [Ingredient] = []
    private var pilha = PilhaDeIngredientes()
    private var spritesColetados: [SKSpriteNode] = []
    private let ordemCorreta = [8, 5, 4, 6, 3, 2, 7, 1]
    
    
    override func didMove(to view: SKView) {
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
    
    private func randomPosition() -> CGPoint {
        CGPoint(x: Int.random(in: -250...250), y: Int.random(in: -250...250))
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
        let id = ingrediente.id
        
        if id == ordemCorreta[pilha.quantidade] {
            coletarIngrediente(ingrediente)
        }
    }
    
    private func coletarIngrediente(_ ingrediente: Ingredient) {
        ingrediente.node.removeFromParent()
        pilha.empilhar(ingrediente)
        collectedIngredients += 1
        mostrarIngredienteColetado(ingrediente)
        
        if pilha.quantidade == totalIngredients {
            let correto = pilha.verificarSeCorreta(com: ordemCorreta)
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
