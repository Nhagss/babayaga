//
//  PhaseOneScene.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//

import SpriteKit
import SwiftUI


class PhaseOneScene: GameSceneBase {
    
    let ingredientesDisponiveis = [
        Ingredient(id: 2, name: "Pó de fada", total: 1),
        Ingredient(id: 3, name: "Asa de morcego", total: 1),
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
        planet2.view.position = CGPoint(x: -150, y: 300)
        
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
        planetControllers[0].view.addIngredient(model: ingredientesDisponiveis[0], angleInDegrees: 300, onCollect: onCollect)
        planetControllers[1].view.addIngredient(model: ingredientesDisponiveis[1], angleInDegrees: 225, onCollect: onCollect)

        /// Adiciona o inimigo porco espinho
        planetControllers[0].addEnemySpike(angleInDegrees: -180)
        planetControllers[1].addEnemySpike(angleInDegrees: 180)
        
        /// Adiciona obstáculos e ornamentos
        planetControllers[0].addHouse(angleInDegrees: 270)
        
        /// Personaliza a aparência dos planetas
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
        
        // 🌍 Inicia a rotação do primeiro planeta para dar mais dinâmica à fase
        planetControllers[0].startRotation()
    }
}
