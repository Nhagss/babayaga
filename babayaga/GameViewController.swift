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
    
    var engine: CHHapticEngine?
    var spriteKitView = SKView()
    let scene = PhaseOneScene()
    let backgroundView = UIHostingController(rootView: BackgroundGame())
    
    var inventoryStackView: UIStackView!
    
    var controlsView: UIHostingController<GameControlsView>?
    
    var capsuleView: UIView! = {
        let capsule = UIView()
        capsule.backgroundColor = .systemGray
        capsule.layer.cornerRadius = 10
        capsule.layer.masksToBounds = true
        capsule.translatesAutoresizingMaskIntoConstraints = false
        capsule.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return capsule;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareHaptics()
        addChild(backgroundView)
        view.addSubview(backgroundView.view)
        backgroundView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.view.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        backgroundView.didMove(toParent: self)
        
        // SpriteKit
        scene.size = view.bounds.size
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        spriteKitView.presentScene(scene)
        spriteKitView.backgroundColor = .clear
        spriteKitView.allowsTransparency = true
        spriteKitView.frame = view.bounds
        view.addSubview(spriteKitView)
        
        // Criando o UIHostingController para os controles
        controlsView = UIHostingController(rootView: GameControlsView(
            onChangeDirection: { [weak self] in
                self?.scene.planetControllers[self?.scene.currentPlanetIndex ?? 0].reverseRotation()
                self?.complexSuccess()
            },
            onChangePlanet: { [weak self] in
                self?.scene.planetControllers[self?.scene.currentPlanetIndex ?? 0].jump()
                self?.scene.changePlanet()
                self?.complexSuccess()
            }
        ))

        
        // Adicionando a view do UIHostingController à hierarquia
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

        view.addSubview(capsuleView)
        
        #if DEBUG
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = true
        spriteKitView.showsNodeCount = true
        #endif
        
        // Configuração do Inventário (UIStackView)
        inventoryStackView = UIStackView()
        inventoryStackView.axis = .horizontal // Agora os ingredientes vão se alinhar horizontalmente
        inventoryStackView.spacing = 10
        inventoryStackView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(inventoryStackView)
        
        NSLayoutConstraint.activate([
            inventoryStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            inventoryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            inventoryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            capsuleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            capsuleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            capsuleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // Configuração do closure para notificar a GameViewController
        scene.onIngredientCollected = { [weak self] collectedIngredients in
            // Aqui, vamos garantir que estamos passando um array de IngredientController
            let ingredientControllers = collectedIngredients.map { IngredientController(model: $0) }
            self?.updateInventory(with: ingredientControllers)
        }
    }
    
    // Atualiza a UI com as views dos ingredientes coletados
    func updateInventory(with stack: [IngredientController]) {
        // Limpa o inventário atual
        inventoryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Adiciona as views dos ingredientes no StackView
        for ingredientController in stack {
            // Cria a imagem usando o nome do arquivo do ingrediente
            let imageName = "goldCoin\(ingredientController.model.id)"
            if let image = UIImage(named: imageName) {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                inventoryStackView.addArrangedSubview(imageView)
            }
        }
    }
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
    
    // Funções de orientação e status bar (mantidas como antes)
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
