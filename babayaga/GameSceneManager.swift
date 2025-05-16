//
//  GameSceneManager.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//
// GameSceneManager.swift

import SpriteKit
import SwiftUI
import Combine

class GameSceneManager: ObservableObject {
    @Published var currentScene: GameSceneBase?
    @Published var currentLevel: Int = 1
    @Published var isShowingLevelSelection = false
    @Published var ingredients = [Ingredient]()
    @Published var isShowingTransition = false
    
    weak var viewController: GameViewController?
    
    var cancellables = Set<AnyCancellable>()
    
    init(viewController: GameViewController? = nil) {
        self.viewController = viewController
    }
    
    func checkIngredients() {
        let remaining = ingredients.map(\.remaining).reduce(0, +)
        if remaining == 0 {
            showTransition()
        }
    }
    
    private func showTransition() {
        isShowingTransition = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.isShowingTransition = false
            self?.nextLevel()
        }
    }
    
    func loadScene(forLevel level: Int) {
        guard let viewController = viewController else { return }
        
        let newScene: GameSceneBase?
        
        switch level {
        case 1:
            newScene = PhaseOneScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 2:
            newScene = PhaseThreeScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 3:
            newScene = PhaseTwoScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 4:
            newScene = LastPhaseScene(gameSceneManager: self, size: viewController.view.bounds.size)
        default:
            newScene = nil
        }
        
        guard let scene = newScene else { return }
        
        scene.onAllIngredientsCollected = { [weak self] in
            self?.showTransition()
        }
        
        let transition = SKTransition.fade(withDuration: 0)
        currentScene = scene
        viewController.spriteKitView.presentScene(scene, transition: transition)
        viewController.setupUi()
        viewController.setupControls()
        viewController.setupTransitionOverlay()
        isShowingLevelSelection = false
    }
    
    func nextLevel() {
        currentLevel += 1
        loadScene(forLevel: currentLevel)
    }
}
