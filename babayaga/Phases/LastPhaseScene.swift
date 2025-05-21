//  DemoEndScene.swift
//  babayaga
//
//  Created by Yago Souza Ramos on 5/16/25.
//

import SpriteKit
import SwiftUI


class LastPhaseScene: GameSceneBase {
    
    let ingredientesDisponiveis = [
        Ingredient(id: 1, name: "Pó de fada", total: 1),
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
        let rawSkin = UserDefaults.standard.string(forKey: "selectedSkin") ?? "morgana"
        let skin = CharacterSkin(rawValue: rawSkin) ?? .morgana
        let planet1 = PlanetController(skin: skin)
        
        /// Configuração das posições dos planetas (mais variada)
        planet1.view.position = CGPoint(x: 0, y: 0)
        
        /// Adiciona planetas à lista
        planetControllers = [planet1]
        
        /// Adiciona os planetas à cena
        for controller in planetControllers {
            gameWorld.addChild(controller.view)
        }
        
        let onCollect = { [weak self] in
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
