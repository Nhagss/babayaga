//
//  PhaseSevenScene.swift
//  babayaga
//
//  Created by honorio on 21/05/25.
//

import Foundation
import SwiftUI
import SpriteKit

class PhaseSevenScene: GameSceneBase {
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Olho de tritão", total: 2),
        Ingredient(id: 2, name: "Pó de fada", total: 2),
        Ingredient(id: 3, name: "Asa de morcego", total: 1)
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
        
        // MARK: Criação dos Planetas
        let planet1 = PlanetController()
        let planet2 = PlanetController(parent: planet1)
        let planet3 = PlanetController(parent: planet2)
        let planet4 = PlanetController(parent: planet3)
        let planet5 = PlanetController(parent: planet4)
        let planet6 = PlanetController(parent: planet5)
        
        /// Configuração das posições dos planetas
        planet1.view.position = CGPoint(x: 0, y: 50)
        planet2.view.position = CGPoint(x: 300, y: 400)
        planet3.view.position = CGPoint(x: 0, y: 700)
        planet4.view.position = CGPoint(x: 200, y: 1100)
        planet5.view.position = CGPoint(x: -50, y: 1400)
        planet6.view.position = CGPoint(x: 200, y: 1700)

        
        planetControllers = [planet1, planet2, planet3, planet4, planet5, planet6]
        
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }
        
        // Ingredientes
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[2].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 210, onCollect: onCollect)
        planetControllers[3].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 80, onCollect: onCollect)
        planetControllers[4].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 240, onCollect: onCollect)
        planetControllers[5].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 180, onCollect: onCollect)
        
        // Obstáculos Spike
        planetControllers[0].addEnemySpike(angleInDegrees: 110)
        planetControllers[1].addEnemySpike(angleInDegrees: 45)
        planetControllers[2].addEnemySpike(angleInDegrees: 120)
        planetControllers[3].addEnemySpike(angleInDegrees: 20)
        planetControllers[4].addEnemySpike(angleInDegrees: 90)
        
        // Morcego
        planetControllers[2].addMultipleEnemyBat(angleInDegrees: 270, delayApparitions: 2.5, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .clockwise)
        planetControllers[4].addMultipleEnemyBat(angleInDegrees: 260, delayApparitions: 2.0, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .clockwise)

        // Casa da vovó
        planetControllers[0].addHouse(angleInDegrees: 180)
        
        // Tipo de planeta
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        planetControllers[2].makePlanetType(type: .threeGrass)
        planetControllers[3].makePlanetType(type: .twoGrass)
        planetControllers[4].makePlanetType(type: .threeGrass)
        planetControllers[5].makePlanetType(type: .twoGrass)
        
        planetControllers[0].startRotation()
    }
}
