//
//  PlanertController.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation

class PlanetController {
    let model: PlanetModel
    let view: PlanetView

    init(model: PlanetModel = PlanetModel(), view: PlanetView = PlanetView()) {
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
}
