//
//  PhaseElevenScene.swift
//  babayaga
//
//  Created by Melissa Freire Guedes on 21/05/25.
//

import SwiftUI
import SpriteKit

class PhaseElevenScene: GameSceneBase {
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Olho de tritão", total: 3),
        Ingredient(id: 2, name: "Pó de fada", total: 3),
        Ingredient(id: 3, name: "Asa de morcego", total: 3)
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
        let planet7 = PlanetController(parent: planet6)
        
        /// Configuração das posições dos planetas (mais variada)
        planet1.view.position = CGPoint(x: 50, y: -150)
        planet2.view.position = CGPoint(x: -150, y: 300)
        planet3.view.position = CGPoint(x: 50, y: 600)
        planet4.view.position = CGPoint(x: -150, y: 900)
        planet5.view.position = CGPoint(x: 50, y: 1200)
        planet6.view.position = CGPoint(x: -150, y: 1500)
        planet7.view.position = CGPoint(x: 50, y: 1800)
        
        /// Adiciona planetas à lista
        planetControllers = [planet1, planet2, planet3, planet4, planet5, planet6, planet7]
        
        /// Adiciona os planetas à cena
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }
        
        /// Distribui os ingredientes com dificuldade ajustada
        planetControllers[0].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 225, onCollect: onCollect)
        planetControllers[2].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[3].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[4].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[4].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 350, onCollect: onCollect)
        planetControllers[5].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 360, onCollect: onCollect)
        planetControllers[6].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[6].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 350, onCollect: onCollect)
        
        
        //Adiciona o inimigo porco espinho
        planetControllers[0].addEnemySpike(angleInDegrees: -180)
        planetControllers[1].addEnemySpike(angleInDegrees: 180)
        planetControllers[2].addEnemySpike(angleInDegrees: 150)
//        planetControllers[3].addEnemySpike(angleInDegrees: 180)
        planetControllers[4].addEnemySpike(angleInDegrees: 150)
        planetControllers[5].addEnemySpike(angleInDegrees: 180)
        planetControllers[6].addEnemySpike(angleInDegrees: -180)
        
        //Adiciona o inimigo morcego
       planetControllers[3].addMultipleEnemyBat(angleInDegrees: 0, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .counterClockwise)
        planetControllers[5].addMultipleEnemyBat(angleInDegrees: 0, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .counterClockwise)
        
        
        /// Adiciona obstáculos e ornamentos
        planetControllers[0].addHouse(angleInDegrees: 270)
        
        /// Personaliza a aparência dos planetas
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        planetControllers[2].makePlanetType(type: .threeGrass)
        planetControllers[3].makePlanetType(type: .threeGrass)
        planetControllers[4].makePlanetType(type: .twoGrass)
        planetControllers[5].makePlanetType(type: .twoGrass)
        planetControllers[6].makePlanetType(type: .threeGrass)
        
        // 🌍 Inicia a rotação do primeiro planeta para dar mais dinâmica à fase
        planetControllers[0].startRotation()
    }
}


#Preview {
    GameViewController()
}
