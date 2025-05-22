//
//  PhaseTenScene.swift
//  babayaga
//
//  Created by honorio on 21/05/25.
//

import Foundation
import SwiftUI
import SpriteKit

class PhaseTenScene: GameSceneBase {
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Olho de tritão", total: 2),
        Ingredient(id: 2, name: "Pó de fada", total: 3),
        Ingredient(id: 3, name: "Asa de morcego", total: 2)
    ]
    
    init(gameSceneManager: GameSceneManager? = nil, size: CGSize) {
        super.init(size: size)
        self.gameSceneManager = gameSceneManager
        
        DispatchQueue.main.async {
            self.gameSceneManager?.ingredients = self.ingredientesDisponiveis
        }
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupPlanets() {
        super.setupPlanets()
        
        backgroundColor = .clear

        // MARK: Criação dos Planetas (zigzag mais espaçado)
        let planet1 = PlanetController()
        let planet2 = PlanetController(parent: planet1)
        let planet3 = PlanetController(parent: planet2)
        let planet4 = PlanetController(parent: planet3)
        let planet5 = PlanetController(parent: planet4)
        let planet6 = PlanetController(parent: planet5)
        
        planet1.view.position = CGPoint(x: 120, y: -150)
        planet2.view.position = CGPoint(x: -120, y: 200)
        planet3.view.position = CGPoint(x: 120, y: 550)
        planet4.view.position = CGPoint(x: -120, y: 900)
        planet5.view.position = CGPoint(x: 120, y: 1250)
        planet6.view.position = CGPoint(x: -120, y: 1600)

        planetControllers = [planet1, planet2, planet3, planet4, planet5, planet6]

        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }

        // Ingredientes (7 total, com ângulos mais acessíveis)
        planetControllers[0].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 270, onCollect: onCollect)
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 140, onCollect: onCollect)
        planetControllers[2].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: -210, onCollect: onCollect)
        planetControllers[3].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 160, onCollect: onCollect)
        planetControllers[4].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 90, onCollect: onCollect)
        planetControllers[5].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 100, onCollect: onCollect)
        planetControllers[5].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 270, onCollect: onCollect)

        // Morcego
        planetControllers[1].addMultipleEnemyBat(angleInDegrees: 90, delayApparitions: 4.0, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)
        planetControllers[3].addMultipleEnemyBat(angleInDegrees: 250, delayApparitions: 4.0, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)

        // Apenas 2 spikes
        planetControllers[1].addEnemySpike(angleInDegrees: 90)
        planetControllers[2].addEnemySpike(angleInDegrees: 180)
        planetControllers[4].addEnemySpike(angleInDegrees: 150)

        // Casa da vovó
        planetControllers[0].addHouse(angleInDegrees: 0)

        // Aparência dos planetas
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        planetControllers[2].makePlanetType(type: .threeGrass)
        planetControllers[3].makePlanetType(type: .twoGrass)
        planetControllers[4].makePlanetType(type: .threeGrass)
        planetControllers[5].makePlanetType(type: .threeGrass)

        planetControllers[0].startRotation()
    }
}
