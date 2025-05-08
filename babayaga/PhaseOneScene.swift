//
//  PhaseOneScene.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//

import SpriteKit
import SwiftUI


class PhaseOneScene: GameSceneBase {
    
    private let ingredientesDisponiveis = [
        (1, "Pó de fada"),
        (2, "Suor de goblin"),
        (3, "Escamas de dragão"),
        (4, "Dente de troll"),
        (5, "Chifre de unicórnio"),
        (6, "Lágrima de fênix")
    ]
    
    override func setupPlanets() {
        super.setupPlanets()
        
        // MARK: Criação dos Planetas
        let planet1 = PlanetController()
        let planet2 = PlanetController(parent: planet1)
        let planet3 = PlanetController(parent: planet2)
        let planet4 = PlanetController(parent: planet3)
        let planet5 = PlanetController(parent: planet4)
        
        /// Configuração das posições dos planetas (mais variada)
        planet1.view.position = CGPoint(x: 50, y: -150)
        planet2.view.position = CGPoint(x: -150, y: 300)
        planet3.view.position = CGPoint(x: 50, y: 600)
        planet4.view.position = CGPoint(x: -100, y: 800)
        planet5.view.position = CGPoint(x: 150, y: 1200)
        
        /// Adiciona planetas à lista
        planetControllers = [planet1, planet2, planet3, planet4, planet5]
        
        /// Adiciona os planetas à cena
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        /// Distribui os ingredientes com dificuldade ajustada
        distributeIngredients(ingredientesDisponiveis, toPlanets: planetControllers.count, difficulty: 0.8)
        
        /// Adiciona obstáculos e ornamentos
        planetControllers[0].addHouse(angleInDegrees: 270)
        
        /// Personaliza a aparência dos planetas
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        planetControllers[2].makePlanetType(type: .complete)
        planetControllers[3].makePlanetType(type: .twoGrass)
        planetControllers[4].makePlanetType(type: .complete)
        
        // 🌍 Inicia a rotação do primeiro planeta para dar mais dinâmica à fase
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
