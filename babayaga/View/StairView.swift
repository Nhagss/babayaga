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
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        self.path = path
        self.strokeColor = .gray
        self.alpha = 0.7
        self.lineWidth = 30
        self.zPosition = -10
        
        // Opcional: adicionar física se quiser detecção de contato
        // setupPhysicsBody(from: startPoint, to: endPoint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody(from start: CGPoint, to end: CGPoint) {
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        let length = hypot(dx, dy)
        let angle = atan2(dy, dx)
        
        let body = SKPhysicsBody(rectangleOf: CGSize(width: length, height: 20))
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.stairs
        body.contactTestBitMask = PhysicsCategory.player
        body.collisionBitMask = 0
        
        self.physicsBody = body
        self.zRotation = angle
        self.position = CGPoint(x: (start.x + end.x)/2, y: (start.y + end.y)/2)
    }
    
}
