import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let personagem: UInt32 = 0x1 << 0
    static let ingrediente: UInt32 = 0x1 << 1
    static let obstaculo: UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var personagem: SKSpriteNode!
    private var obstaculo: SKSpriteNode!
    private var listLabel: SKLabelNode?
    private var collectedIngredients = 0
    private let totalIngredients = 8
    private var helloLabel: SKLabelNode?
    
    private var ingredientes: [Ingredient] = []
    private var pilha = PilhaDeIngredientes()
    private var spritesColetados: [SKSpriteNode] = []
    private let ordemCorreta = [8, 5, 4, 6, 3, 2, 7, 1]
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.categoryBitMask = 0
        
        helloLabel = childNode(withName: "//helloLabel") as? SKLabelNode
        listLabel = childNode(withName: "//listLabel") as? SKLabelNode
        
        helloLabel?.run(SKAction.fadeIn(withDuration: 2.0))
        listLabel?.run(SKAction.fadeIn(withDuration: 2.0))
        listLabel?.text = "Coletados: 0"
        
        setupPersonagem()
        setupObstaculo()
        spawnIngredients()
        mostrarOrdemCorretaVisual()
    }
    
    private func setupPersonagem() {
        personagem = SKSpriteNode(color: .purple, size: CGSize(width: 60, height: 60))
        personagem.position = .zero
        personagem.zPosition = 1
        personagem.name = "Personagem"
        
        personagem.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        personagem.physicsBody?.affectedByGravity = false
        personagem.physicsBody?.categoryBitMask = PhysicsCategory.personagem
        personagem.physicsBody?.contactTestBitMask = PhysicsCategory.ingrediente | PhysicsCategory.obstaculo
        personagem.physicsBody?.collisionBitMask = 0
        
        addChild(personagem)
    }
    
    private func setupObstaculo() {
        obstaculo = SKSpriteNode(color: .red, size: CGSize(width: 60, height: 60))
        obstaculo.position = CGPoint(x: 60, y: 40)
        obstaculo.name = "Inimigo"
        
        obstaculo.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        obstaculo.physicsBody?.isDynamic = false
        obstaculo.physicsBody?.categoryBitMask = PhysicsCategory.obstaculo
        obstaculo.physicsBody?.contactTestBitMask = PhysicsCategory.personagem
        obstaculo.physicsBody?.collisionBitMask = 0
        
        addChild(obstaculo)
    }
    
    private func spawnIngredients() {
        let nomes = [
            (1, "Pó de fada"), (2, "Suor de goblin"), (3, "Pena de corvo"),
            (4, "Água da lua cheia"), (5, "Escama de Dragão"), (6, "Mel de flores silvestres"),
            (7, "Sal negro do Himalaia"), (8, "Artemísia")
        ]
        
        for (id, nome) in nomes.shuffled() {
            let ingrediente = Ingredient(id: id, nome: nome, texture: SKTexture(imageNamed: "goldCoin\(id)"))
            ingrediente.node.position = randomPosition()
            ingrediente.node.name = "Ingredient_\(id)"
            
            ingrediente.node.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            ingrediente.node.physicsBody?.isDynamic = false
            ingrediente.node.physicsBody?.categoryBitMask = PhysicsCategory.ingrediente
            ingrediente.node.physicsBody?.contactTestBitMask = PhysicsCategory.personagem
            ingrediente.node.physicsBody?.collisionBitMask = 0
            
            ingredientes.append(ingrediente)
            addChild(ingrediente.node)
        }
    }
    
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let a = contact.bodyA
        let b = contact.bodyB
        
        let bodies = [a, b]
        
        if bodies.contains(where: { $0.categoryBitMask == PhysicsCategory.obstaculo }) {
            pilha.inverterPilha()
            atualizarSpritesColetados()
            return
        }
        
        if let ingredienteNode = bodies.first(where: { $0.categoryBitMask == PhysicsCategory.ingrediente })?.node,
           let ingrediente = ingredientes.first(where: { $0.node == ingredienteNode }) {
            processarIngrediente(ingrediente)
        }
    }
    
    private func processarIngrediente(_ ingrediente: Ingredient) {
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
    
    private func atualizarSpritesColetados() {
        for sprite in spritesColetados {
            sprite.removeFromParent()
        }
        
        spritesColetados.removeAll()
        
        for (index, ingrediente) in pilha.getIngredientes().enumerated() {
            let posX = CGFloat(index) * 45 - 160
            let posY = -size.height / 2 + 50
            let sprite = SKSpriteNode(texture: ingrediente.node.texture)
            sprite.position = CGPoint(x: posX, y: posY)
            sprite.setScale(0.4)
            spritesColetados.append(sprite)
            addChild(sprite)
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
