//  DemoEndScene.swift
//  babayaga
//
//  Created by Yago Souza Ramos on 5/16/25.
//

import SpriteKit
import SwiftUI


class LastPhaseScene: GameSceneBase {
            
    init(gameSceneManager: GameSceneManager? = nil, size: CGSize) {
        super.init(size: size)
        self.gameSceneManager = gameSceneManager
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupPlanets() {
        super.setupPlanets()
        
        backgroundColor = .clear
        
        // MARK: Criação dos Planetas
        let planet1 = PlanetController()
        
        /// Configuração das posições dos planetas (mais variada)
        planet1.view.position = CGPoint(x: 0, y: 0)
        
        /// Adiciona planetas à lista
        planetControllers = [planet1]
        
        /// Adiciona os planetas à cena
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        _ = { [weak self] in
            guard let self else { return }
            gameSceneManager?.checkIngredients()
        }
        
        
        /// Adiciona obstáculos e ornamentos
        planetControllers[0].addFinalHouse(angleInDegrees: 90)
        
        /// Personaliza a aparência dos planetas
        planetControllers[0].makePlanetType(type: .complete)
        
        // 🌍 Inicia a rotação do primeiro planeta para dar mais dinâmica à fase
        planetControllers[0].startRotation()
    }
}
