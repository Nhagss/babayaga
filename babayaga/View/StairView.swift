//
//  StairView.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import SpriteKit

class StairView: SKShapeNode {
    
    init(from startPoint: CGPoint, to endPoint: CGPoint) {
        super.init()

        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let length = hypot(dx, dy)
        let angle = atan2(dy, dx)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -length/2, y: 0))
        path.addLine(to: CGPoint(x: length/2, y: 0))
        
        self.path = path
        self.strokeColor = .systemPurple
        self.alpha = 0.7
        self.lineWidth = 30
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
