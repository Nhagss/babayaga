//
//  PhaseFifteenScene.swift
//  babayaga
//
//  Created by Melissa Freire Guedes on 21/05/25.
//

import SwiftUI
import SpriteKit

class PhaseFifteenScene: GameSceneBase {
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Olho de tritão", total: 6), //tinha 4
        Ingredient(id: 2, name: "Pó de fada", total: 6),
        Ingredient(id: 3, name: "Asa de morcego", total: 6)
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
        let planet8 = PlanetController(parent: planet7)
        let planet9 = PlanetController(parent: planet8)
        let planet10 = PlanetController(parent: planet9)
        let planet11 = PlanetController(parent: planet10)
        let planet12 = PlanetController(parent: planet11)
        
        /// Configuração das posições dos planetas (mais variada)
        planet1.view.position = CGPoint(x: 0, y: -100)
        planet2.view.position = CGPoint(x: 100, y: 250)
        planet3.view.position = CGPoint(x: -100, y: 600)
        planet4.view.position = CGPoint(x: 0, y: 1050)
        planet5.view.position = CGPoint(x: 0, y: 1500)
        planet6.view.position = CGPoint(x: -150, y: 1900)
        planet7.view.position = CGPoint(x: -0, y: 2300)
        planet8.view.position = CGPoint(x: -150, y: 2700)
        planet9.view.position = CGPoint(x: -100, y: 3100)
        planet10.view.position = CGPoint(x: 0, y: 3500)
        planet11.view.position = CGPoint(x: -150, y: 3900)
        planet12.view.position = CGPoint(x: -100, y: 4300)
        
        /// Adiciona planetas à lista
        planetControllers = [planet1, planet2, planet3, planet4, planet5, planet6, planet7, planet8, planet9, planet10, planet11, planet12]
        
        /// Adiciona os planetas à cena
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }
        
        /// Distribui os ingredientes com dificuldade ajustada
        planetControllers[0].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 225, onCollect: onCollect)
        planetControllers[2].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 225, onCollect: onCollect)
        planetControllers[3].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 225, onCollect: onCollect)
        planetControllers[4].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[4].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 350, onCollect: onCollect)
        planetControllers[5].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 225, onCollect: onCollect)
        planetControllers[6].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[6].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 350, onCollect: onCollect)
        planetControllers[7].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[7].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 225, onCollect: onCollect)
        planetControllers[8].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 360, onCollect: onCollect)
        planetControllers[8].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[9].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 350, onCollect: onCollect)
        planetControllers[9].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[10].view.addIngredient(model: ingredientesDisponiveis[2], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[11].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 180, onCollect: onCollect)
        planetControllers[11].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 225, onCollect: onCollect)
        
        
        //Adiciona o inimigo porco espinho
        planetControllers[0].addEnemySpike(angleInDegrees: -180)
        planetControllers[1].addEnemySpike(angleInDegrees: 180)
        planetControllers[2].addEnemySpike(angleInDegrees: 150)
        planetControllers[3].addEnemySpike(angleInDegrees: 180)
//        planetControllers[4].addEnemySpike(angleInDegrees: 150)
        planetControllers[5].addEnemySpike(angleInDegrees: 180)
        planetControllers[6].addEnemySpike(angleInDegrees: -180)
        planetControllers[9].addEnemySpike(angleInDegrees: 225)
        planetControllers[10].addEnemySpike(angleInDegrees: 150)
        
        //Adiciona o inimigo morcego
       planetControllers[4].addMultipleEnemyBat(angleInDegrees: 90, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)
        planetControllers[7].addMultipleEnemyBat(angleInDegrees: 275, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .counterClockwise)
        planetControllers[3].addMultipleEnemyBat(angleInDegrees: 225, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)
        planetControllers[5].addMultipleEnemyBat(angleInDegrees: 180, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .counterClockwise)
        planetControllers[1].addMultipleEnemyBat(angleInDegrees: 225, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)
        planetControllers[8].addMultipleEnemyBat(angleInDegrees: 225, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)
        planetControllers[10].addMultipleEnemyBat(angleInDegrees: 225, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 1, rotationDirection: .counterClockwise)
        planetControllers[11].addMultipleEnemyBat(angleInDegrees: 225, delayApparitions: 3, rotationTimes: 1, numberOfEnemyBat: 2, rotationDirection: .counterClockwise)
        
        
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
        planetControllers[7].makePlanetType(type: .twoGrass)
        planetControllers[8].makePlanetType(type: .twoGrass)
        planetControllers[9].makePlanetType(type: .threeGrass)
        planetControllers[10].makePlanetType(type: .threeGrass)
        planetControllers[11].makePlanetType(type: .threeGrass)
        
        // 🌍 Inicia a rotação do primeiro planeta para dar mais dinâmica à fase
        planetControllers[0].startRotation()
    }
}


#Preview {
    GameViewController()
}

