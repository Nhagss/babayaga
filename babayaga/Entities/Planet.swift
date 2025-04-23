//
//  Planet.swift
//  babayaga
//
//  Created by user on 23/04/25.
//

import Foundation
import SpriteKit
import GameplayKit

class Planet {
    var player: SKSpriteNode!
    var world: SKShapeNode!
    var playerAnchor: SKSpriteNode!
    var rotationSpeed: CGFloat = 3
    var positioner: SKSpriteNode!
    var isContactingStair: Bool = false
    
    func changeDirection(){
        // Reverte o valor da velocidade de rotação
        rotationSpeed = -rotationSpeed
        
        // Apaga a rotação anterior
        playerAnchor.removeAction(forKey: "playerRotation")
        
        // Cria uma rotação para o objeto
        let rotateAction = SKAction.rotate(byAngle: rotationSpeed, duration: 1)
        let repeatAction = SKAction.repeatForever(rotateAction)
        
        // sobrescreve a direção de rotação anterior
        playerAnchor.run(repeatAction, withKey: "playerRotation")
    }
    
    func pauseRotation() {
        playerAnchor.removeAction(forKey: "playerRotation")
    }
    
    func unPauseRotation() {
        // Cria uma rotação para o objeto
        let rotateAction = SKAction.rotate(byAngle: rotationSpeed, duration: 1)
        let repeatAction = SKAction.repeatForever(rotateAction)
        
        // sobrescreve a direção de rotação anterior
        playerAnchor.run(repeatAction, withKey: "playerRotation")
        
    }
    
    func slowDownRotation() {
        let sign = rotationSpeed > 0 ? 1 : -1
        playerAnchor.removeAction(forKey: "playerRotation")
        // Cria uma rotação para o objeto
        let rotateAction = SKAction.rotate(byAngle: 1  * CGFloat(sign), duration: 1)
        let repeatAction = SKAction.repeatForever(rotateAction)
        
        // sobrescreve a direção de rotação anterior
        playerAnchor.run(repeatAction, withKey: "playerRotation")
    }
    
    func regularRotation() {
        
        let sign = rotationSpeed > 0 ? 1 : -1
        playerAnchor.removeAction(forKey: "playerRotation")
        
        // Cria uma rotação para o objeto
        let rotateAction = SKAction.rotate(byAngle: 3 * CGFloat(sign), duration: 1)
        let repeatAction = SKAction.repeatForever(rotateAction)
        
        // sobrescreve a direção de rotação anterior
        playerAnchor.run(repeatAction, withKey: "playerRotation")
    }
    
    func jump() {
        let jumpAction = SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0.1)
        let returnAction = SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 0.1)
        jumpAction.timingMode = .easeOut
        returnAction.timingMode = .easeIn
        let wait = SKAction.wait(forDuration: 0.1)
        let jumpSequence = SKAction.sequence([jumpAction, wait, returnAction])
        
        player.run(jumpSequence)
    }
    
}
