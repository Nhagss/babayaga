//
//  PlanertController.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation
import SpriteKit

enum PlanetType {
    case twoGrass, threeGrass, complete
}

class PlanetController {
    let id: UUID = UUID()
    let parent: PlanetController?
    let model: Planet
    let view: PlanetView
    
    var isContactingStair: Bool {
        get { model.isContactingStair }
        set { model.isContactingStair = newValue }
    }
    
    init(parent: PlanetController? = nil, model: Planet = Planet(), view: PlanetView = PlanetView()) {
        
        self.parent = parent
        self.model = model
        self.view = view
    }
    
    func startRotation() {
        view.rotate(speed: model.regularSpeed())
    }
    
    func stopRotation() {
        view.stopRotation()
    }
    
    func slowDownRotation() {
        view.rotate(speed: model.slowedSpeed())
    }
    
    func jump() {
        view.playerNode.jump()
    }
    
    func reverseRotation() {
        view.playerNode.xScale *= -1
        model.reverseDirection()
        startRotation()
    }
    
    func addObject(angleInDegrees: CGFloat) {
        view.addObject(angleInDegrees: angleInDegrees)
    }
    
    func addHouse(angleInDegrees: CGFloat) -> Void {
        let scale = 1.3
        let treeSize: CGSize = CGSize(width: 150/scale, height: 200/scale)
        view.addObject(angleInDegrees: angleInDegrees, withCollision: true, isHouse: false, texture: SKTexture(imageNamed: "house"), size: treeSize)
    }
    
    func addTree(angleInDegrees: CGFloat) {
        let scale = 1.3
        let treeSize: CGSize = CGSize(width: 150/scale, height: 200/scale)
        view.addObject(angleInDegrees: angleInDegrees, texture: SKTexture(imageNamed: "worldTree"), size: treeSize)
        
    }
    
    func addGrass(angleInDegrees: CGFloat) {
        let scale = 1.3
        let grassSize: CGSize = CGSize(width: 131/scale, height: 76/scale)
        view.addObject(angleInDegrees: angleInDegrees, texture: SKTexture(imageNamed: "grass"), size: grassSize, distanceToPlanet: -20)
    }
    
    func addCross(angleInDegrees: CGFloat) {
        let scale = 1.3
        let crossSize: CGSize = CGSize(width: 50/scale, height: 50/scale)
        view.addObject(angleInDegrees: angleInDegrees, texture: SKTexture(imageNamed: "cross"), size: crossSize)
    }
    
    func makePlanetType(type: PlanetType) {
        
        let scale = 1.3        
        switch type {
        case .complete:
            addGrass(angleInDegrees: 90)
            addGrass(angleInDegrees: 190)
            addGrass(angleInDegrees: 280)
            addTree(angleInDegrees: 40)
            addCross(angleInDegrees: -15)
            break
            
        case .threeGrass:
            addGrass(angleInDegrees: 70)
            addGrass(angleInDegrees: 170)
            addGrass(angleInDegrees: 280)
            break
        case .twoGrass:
            addGrass(angleInDegrees: 340)
            addGrass(angleInDegrees: 100)
            break
        default:
            print("not a planet type")
            break
        }
        
    }
}
