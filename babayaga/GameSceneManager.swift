//
//  GameSceneManager.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//
// GameSceneManager.swift

import SpriteKit
import SwiftUI

class GameSceneManager: ObservableObject {
    @Published var currentScene: GameSceneBase?
    @Published var currentLevel: Int = 1
    @Published var isShowingLevelSelection = false
    @Published var ingredients = [Ingredient]()
    
    weak var viewController: GameViewController?
    
    init(viewController: GameViewController? = nil) {
        self.viewController = viewController
    }
    
    func loadScene(forLevel level: Int) {
        var newScene: GameSceneBase?
        
        switch level {
        case 1:
            newScene = PhaseOneScene(gameSceneManager: self, size: viewController!.view.bounds.size)
        case 2:
            newScene = PhaseTwoScene(gameSceneManager: self, size: viewController!.view.bounds.size)
        default:
            newScene = PhaseOneScene(gameSceneManager: self, size: viewController!.view.bounds.size)
        }
        
        // Configura o callback para quando todos os ingredientes forem coletados
        newScene?.onAllIngredientsCollected = { [weak self] in
            self?.nextLevel()
        }
        
        currentScene = newScene
        viewController?.spriteKitView.presentScene(newScene)
        
        // Fecha a tela de seleção ao carregar uma nova fase
        isShowingLevelSelection = false
    }
    
    func nextLevel() {
        currentLevel += 1
        loadScene(forLevel: currentLevel)
    }
}
