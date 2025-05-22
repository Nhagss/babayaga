//
//  PhaseEightScene.swift
//  babayaga
//
//  Created by honorio on 21/05/25.
//

import Foundation
import SwiftUI
import SpriteKit

class PhaseNineScene: GameSceneBase {
    
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Olho de tritão", total: 2),
        Ingredient(id: 3, name: "Asa de morcego", total: 1),
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
        
        /// Configuração das posições dos planetas
        planet1.view.position = CGPoint(x: 0, y: 50)
        planet2.view.position = CGPoint(x: 300, y: -200)
        planet3.view.position = CGPoint(x: 700, y: -100)
        planet4.view.position = CGPoint(x: 500, y: 300)

        planetControllers = [planet1, planet2, planet3, planet4]
        
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }
        
        // Ingredientes
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 100, onCollect: onCollect)
        planetControllers[2].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 0, onCollect: onCollect)
        planetControllers[3].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 80, onCollect: onCollect)
        
        // Obstáculos Spike
        planetControllers[0].addEnemySpike(angleInDegrees: 90)
        planetControllers[1].addEnemySpike(angleInDegrees: 45)
        planetControllers[3].addEnemySpike(angleInDegrees: 15)
        
        // Morcego
        planetControllers[1].addMultipleEnemyBat(angleInDegrees: 180, delayApparitions: 2.0, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .clockwise)
        
        planetControllers[2].addMultipleEnemyBat(angleInDegrees: 0, delayApparitions: 3.0, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .counterClockwise)

        // Casa da vovó
        planetControllers[0].addHouse(angleInDegrees: -180)
        
        // Tipo de planeta
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        planetControllers[2].makePlanetType(type: .threeGrass)
        planetControllers[3].makePlanetType(type: .threeGrass)
        
        planetControllers[0].startRotation()
    }
}
