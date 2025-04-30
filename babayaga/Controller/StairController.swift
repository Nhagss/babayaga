//
//  PlanertController.swift
//  babayaga
//
//  Created by user on 25/04/25.
//

import Foundation

class StairController {
    let id: UUID = UUID()
    let startPlanet: PlanetController
    let endPlanet: PlanetController
    let view: StairView
    
    init(from startPlanet: PlanetController, to endPlanet: PlanetController) {
        self.startPlanet = startPlanet
        self.endPlanet = endPlanet
        self.view = StairView(from: self.startPlanet, to: self.endPlanet)
    }
    
    func getJumpDestination(currentPlanet: UUID) -> UUID {
        if currentPlanet == startPlanet.id {
            return endPlanet.id
        } else {
            return startPlanet.id
        }
    }
}
