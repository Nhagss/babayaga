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
    
    static let shared = GameSceneManager()
    
    @Published var currentScene: GameSceneBase?
    @Published var currentLevel: Int = 1
    @Published var isShowingLevelSelection = false
    @Published var ingredients = [Ingredient]()
    @Published var isShowingTransition = false
    
    private var canGoNextLevel: Bool = false
    
    weak var viewController: GameViewController?
    
    var cancellables = Set<AnyCancellable>()
    
    let keyForUserDefaults = "completedLevels"
        
    init(viewController: GameViewController? = nil) {
        self.viewController = viewController
    }
    
    func goToNextLevel(
        onFail: (()->Void)? = nil,
        onSuccess: (()->Void)? = nil
    ) {
        guard canGoNextLevel else {
            onFail?()
            return
        }
        onSuccess?()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.saveLevel(level: self.currentLevel)
            self.showTransition()
        }
    }
    
    func checkIngredients() {
        let remaining = ingredients.map(\.remaining).reduce(0, +)
        if remaining == 0 {
            canGoNextLevel = true
        }
    }
    
    private func showTransition() {
        isShowingTransition = true
        canGoNextLevel = false
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
            newScene = PhaseTwoScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 3:
            newScene = PhaseThreeScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 4:
            newScene = PhaseFourScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 5:
            newScene = PhaseFiveScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 6:
            newScene = PhaseSixScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 7:
            newScene = PhaseSevenScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 8:
            newScene = PhaseEightScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 9:
            newScene = PhaseNineScene(gameSceneManager: self, size: viewController.view.bounds.size)
        case 10:
            newScene = PhaseTenScene(gameSceneManager: self, size: viewController.view.bounds.size)
        default:
            newScene = nil
        }
        
        guard let scene = newScene else { return }
        
        // TODO: Melissa olha se isso faz algo!
        scene.onAllIngredientsCollected = { [weak self] in
            self?.showTransition()
        }
        
        let transition = SKTransition.fade(withDuration: 0)
        viewController.spriteKitView.presentScene(scene, transition: transition)
        viewController.setupUi()
        viewController.setupControls()
        viewController.setupTransitionOverlay()
        
        DispatchQueue.main.async {
            self.currentScene = scene
            self.isShowingLevelSelection = false
        }
    }
    
    private func nextLevel() {
        currentLevel += 1
        loadScene(forLevel: currentLevel)
    }
    
    private func saveLevel(level item: Int) {
        var data = UserDefaults.standard.array(forKey: keyForUserDefaults) as? [Int] ?? []
        
        if !data.contains(item) {
            data.append(item)
            UserDefaults.standard.set(data, forKey: keyForUserDefaults)
//            print("Nível \(item) salvo com sucesso!")
        }
    }
    
    func restartLevel() {
        loadScene(forLevel: currentLevel)
    }
}
