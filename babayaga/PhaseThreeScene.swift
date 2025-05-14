//
//  PhaseOneScene.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//

import SpriteKit
import SwiftUI


class PhaseThreeScene: GameSceneBase {
    
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Pó de fada", total: 1),
        Ingredient(id: 2, name: "Suor de goblin", total: 1),
    ]
        
    var gameSceneManager: GameSceneManager?

    init(gameSceneManager: GameSceneManager? = nil, size: CGSize) {
        self.gameSceneManager = gameSceneManager
        gameSceneManager?.ingredients = ingredientesDisponiveis
        super.init(size: size)
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
        
        /// Configuração das posições dos planetas (mais variada)
        planet1.view.position = CGPoint(x: 50, y: -150)
        planet2.view.position = CGPoint(x: 400, y: -300)
        
        /// Adiciona planetas à lista
        planetControllers = [planet1, planet2]
        
        /// Adiciona os planetas à cena
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }
        
        /// Distribui os ingredientes com dificuldade ajustada
        planetControllers[0].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 45, onCollect: onCollect)
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 270, onCollect: onCollect)
        
        /// Adiciona obstáculos e ornamentos
        planetControllers[0].addHouse(angleInDegrees: 150)
        
        /// Personaliza a aparência dos planetas
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        
        /// Inicia a rotação do primeiro planeta para dar mais dinâmica à fase
        planetControllers[0].startRotation()
    }
}


//class PhaseOneScene: GameSceneBase {
//    
//    private let ingredientesDisponiveis = [
//        (1, "Pó de fada"),
//        (1, "Pó de fada"),
//        (2, "Suor de goblin"),
//        (2, "Suor de goblin"),
//        (2, "Suor de goblin")
//    ]
//    
//    override func setupPlanets() {
//        super.setupPlanets()
//        
//        // MARK: Configuração específica dos planetas para essa fase
//        let planet1 = PlanetController()
//        let planet2 = PlanetController(parent: planet1)
//        planet1.view.position = CGPoint(x: 50, y: -150)
//        planet2.view.position = CGPoint(x: -150, y: 200)
//        
//        planetControllers = [planet1, planet2]
//        
//        for controller in planetControllers {
//            gameWorld.addChild(controller.view)
//        }
//        
//        // MARK: Outros ajustes específicos para Fase
//        /// Exemplo: adicionar 2 ingredientes no planeta 0
//        distributeIngredients(ingredientesDisponiveis, toPlanets: planetControllers.count, difficulty: 0.5)
//        
//        /// Adiciona Obstáculos
//        planetControllers[1].addObject(angleInDegrees: 90)
//
//        /// Iniciar rotação do primeiro planeta
//        planetControllers[0].startRotation()
//        planetControllers[0].addHouse(angleInDegrees: 90)
//        /// Adiciona Ornamentos
//        planetControllers[0].makePlanetType(type: .threeGrass)
//        planetControllers[1].makePlanetType(type: .twoGrass)
//    }
//}
