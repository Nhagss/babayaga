//
//  GameViewController.swift
//  RoundMovementPOC
//
//  Created by Yago Souza Ramos on 4/13/25.
//

import UIKit
import SpriteKit
import SwiftUI
import CoreHaptics

class GameViewController: UIViewController {
    var router: Router = Router.shared
    var engine: CHHapticEngine?
    var spriteKitView = SKView()
    var gameSceneManager = GameSceneManager()
    var controlsView: UIHostingController<GameControlsView>?
    var ingredientPanelView: UIHostingController<IngredientPanelView>?
    
    let backgroundView = UIHostingController(rootView: BackgroundGame())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareHaptics()
        setupBackground()
        
        /// Conecta o GameSceneManager com o ViewController
        gameSceneManager.viewController = self
        
        setupSpriteKitView()
        setupScene()
        setupUi()
        setupControls()        
#if DEBUG
        configureDebugOptions()
#endif
    }
    
    private func setupBackground() {
        addChild(backgroundView)
        view.addSubview(backgroundView.view)
        
        backgroundView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.view.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSpriteKitView() {
        spriteKitView.backgroundColor = .clear
        spriteKitView.allowsTransparency = true
        spriteKitView.frame = view.bounds
        view.addSubview(spriteKitView)
    }
    
    private func setupScene() {
        /// Carrega a primeira fase
        gameSceneManager.loadScene(forLevel: 1)
        
        // SpriteKit
        if let scene = gameSceneManager.currentScene {
            scene.size = view.bounds.size
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .clear
        }
    }
    
    private func setupControls() {
        controlsView = UIHostingController(rootView: GameControlsView(
            onChangeDirection: { [weak self] in
                self?.handleDirectionChange()
            },
            onChangePlanet: { [weak self] in
                self?.handlePlanetChange()
            }
        ))
        
        if let controlsView = controlsView?.view {
            view.addSubview(controlsView)
            controlsView.backgroundColor = .clear
            controlsView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                controlsView.heightAnchor.constraint(equalToConstant: 150) // Ajuste conforme necessário
            ])
        }
    }
    
    private func handleDirectionChange() {
        guard let currentScene = gameSceneManager.currentScene else { return }
        currentScene.planetControllers[currentScene.currentPlanetIndex].reverseRotation()
        self.complexSuccess()
    }
    
    private func handlePlanetChange() {
        guard let currentScene = gameSceneManager.currentScene else { return }
        currentScene.planetControllers[currentScene.currentPlanetIndex].jump()
        currentScene.changePlanet()
        self.complexSuccess()
    }
    
    private func configureDebugOptions() {
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = true
        spriteKitView.showsNodeCount = true
    }
    
    private func setupUi() {
        
        /// Cria o painel de ingredientes
        ingredientPanelView = UIHostingController(
            rootView: IngredientPanelView(gameSceneManager: gameSceneManager)
        )
        guard let ingredientPanelView = ingredientPanelView?.view else { return }
        view.addSubview(ingredientPanelView)
        ingredientPanelView.backgroundColor = .clear
        ingredientPanelView.translatesAutoresizingMaskIntoConstraints = false

        
        /// Cria o botão de pause
        let pauseButton = UIButton(type: .system)
        pauseButton.setBackgroundImage(UIImage(named: "backgroundpause"), for: .normal)
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        pauseButton.tintColor = .white
        pauseButton.contentMode = .scaleAspectFit
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.addTarget(self, action: #selector(openMenuView), for: .touchUpInside)
        view.addSubview(pauseButton)
        
        /// Constraints do painel
        NSLayoutConstraint.activate([
            ingredientPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
        ])

        /// Alinhamento horizontal do botão com o painel de ingredientes
        NSLayoutConstraint.activate([
            pauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            pauseButton.topAnchor.constraint(equalTo: ingredientPanelView.centerYAnchor, constant: 15.0)
        ])
    }
    
    @objc func openMenuView() {
        
        if let scene = gameSceneManager.currentScene {
            scene.isPaused = true
            
            // Cria o menu SwiftUI
            let menuView = MenuView { [weak self] menuButton in
                switch menuButton.destination {
                case .GameViewController:
                    scene.isPaused = false
                    // TODO: Reiniciar jogo!
                    return
                case .InitialScreen:
                    self?.router.backToMenu()
                case .SettingsView:
                    self?.router.goToSettingsView()
                }
            } onClose: { [weak self] in
                scene.isPaused = false
                self?.dismiss(animated: true, completion: nil)
            }
            let hostingController = UIHostingController(rootView: menuView)
            hostingController.modalPresentationStyle = .fullScreen // Apresenta como tela cheia
            present(hostingController, animated: true, completion: nil)
        }
    }
    
    func setupTransitionOverlay() {
        let grannyAnimation = GrannyAnimation(phaseNumber: gameSceneManager.currentLevel + 1)
        let overlayView = UIHostingController(rootView: grannyAnimation)
        addChild(overlayView)
        view.addSubview(overlayView.view)
        
        overlayView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.view.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
         //Esconde inicialmente
        overlayView.view.isHidden = true
        
        // Vincula a visibilidade ao estado do gameSceneManager
        gameSceneManager.$isShowingTransition
            .receive(on: RunLoop.main)
            .sink { isShowing in
                UIView.transition(
                    with: overlayView.view,
                    duration: 0.5,
                    options: .transitionCrossDissolve,
                    animations: {
                        overlayView.view.isHidden = !isShowing
                    },
                    completion: { _ in
                        grannyAnimation.play()
                    }
                )
            }
            .store(in: &gameSceneManager.cancellables)
    }
//
    //MARK: Funções de Haptics custom
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Failed to create engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity , value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    /// Funções de orientação e status bar (mantidas como antes)
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return [.portrait]
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

#Preview {
    GameViewController()
}
