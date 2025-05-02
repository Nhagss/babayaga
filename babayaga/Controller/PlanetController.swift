//
//  PlanertController.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation

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
        model.reverseDirection()
        startRotation()
    }
    
    func addObstacle(angleInDegrees: CGFloat) {
        view.addObstacle(angleInDegrees: angleInDegrees)
    }
}
