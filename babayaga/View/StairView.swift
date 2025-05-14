//
//  StairView.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import SpriteKit

class StairView: SKShapeNode {    
    init(from startPlanet: PlanetController, to endPlanet: PlanetController) {
        super.init()

        let startPoint = startPlanet.view.position
        let endPoint = endPlanet.view.position

        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let length = hypot(dx, dy)
        let angle = atan2(dy, dx)
        
        let portal1 = SKSpriteNode()
        portal1.size = CGSize(width: 40, height: 50)
        portal1.physicsBody = SKPhysicsBody(rectangleOf: portal1.size)
        portal1.physicsBody?.isDynamic = false
        portal1.texture = SKTexture(imageNamed: "portal")
        portal1.zPosition = 10
        portal1.zRotation = -1.5
        
        let portal2 = SKSpriteNode()
        portal2.size = CGSize(width: 40, height: 50)
        portal2.physicsBody = SKPhysicsBody(rectangleOf: portal2.size)
        portal2.physicsBody?.isDynamic = false
        portal2.texture = SKTexture(imageNamed: "portal")
        portal2.zPosition = 10
        portal2.zRotation = 1.5

        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -length/2.1, y: 0))
        
        portal1.position = CGPoint(x: path.currentPoint.x + 100, y: path.currentPoint.y)
        
        path.addLine(to: CGPoint(x: length/2.1, y: 0))
        
        portal2.position = CGPoint(x: path.currentPoint.x - 100, y: path.currentPoint.y)

        addChild(portal1)
        addChild(portal2)
                
        self.path = path
        self.strokeColor = .white
        self.strokeTexture = SKTexture(imageNamed: "portal")
        self.alpha = 1
        self.lineWidth = 4
        self.zPosition = -10

        /// Configura o physicsBody
        //setupPhysicsBody(length: length)
        
        self.position = CGPoint(x: (startPoint.x + endPoint.x)/2, y: (startPoint.y + endPoint.y)/2)
        self.zRotation = angle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody(length: CGFloat) {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: length, height: 30))
        body.isDynamic = true
        body.affectedByGravity = false
        body.categoryBitMask = PhysicsCategory.stair
        body.contactTestBitMask = PhysicsCategory.player
        body.collisionBitMask = PhysicsCategory.none
        
        self.physicsBody = body
        
        #if DEBUG
        let debugShape = SKShapeNode(rectOf: CGSize(width: length, height: 30))
        debugShape.strokeColor = .systemPurple
        debugShape.lineWidth = 2
        debugShape.zPosition = 1000  // Garante que fique por cima de tudo
        addChild(debugShape)
        #endif
    }
}

#Preview {
    GameViewControllerBase()
}
