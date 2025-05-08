//
//  PhaseOneScene.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//

import SpriteKit

class PhaseOneScene: GameSceneBase {
    
    private let ingredientesDisponiveis = [
        (1, "Pó de fada"),
        (1, "Pó de fada"),
        (2, "Suor de goblin"),
        (2, "Suor de goblin"),
        (2, "Suor de goblin")
    ]
    
    override func setupPlanets() {
        super.setupPlanets()
        
        // MARK: Configuração específica dos planetas para essa fase
        let planet1 = PlanetController()
        let planet2 = PlanetController(parent: planet1)
        planet1.view.position = CGPoint(x: 50, y: -150)
        planet2.view.position = CGPoint(x: -150, y: 200)
        
        planetControllers = [planet1, planet2]
        
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        // MARK: Outros ajustes específicos para Fase
        /// Exemplo: adicionar 2 ingredientes no planeta 0
        for (id, name) in ingredientesDisponiveis.shuffled().prefix(2) {
            let ingrediente = Ingredient(id: id, name: name)
            planetControllers[0].view.addIngredient(model: ingrediente, angleInDegrees: CGFloat.random(in: 0...360))
        }
        
        /// Adiciona Obstáculos
        planetControllers[1].addObject(angleInDegrees: 90)

        /// Iniciar rotação do primeiro planeta
        planetControllers[0].startRotation()
        
        /// Adiciona Ornamentos
        planetControllers[0].makePlanetType(type: .threeGrass)
        planetControllers[1].makePlanetType(type: .twoGrass)
    }
}
