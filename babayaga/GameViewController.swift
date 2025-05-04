//
//  GameViewController.swift
//  RoundMovementPOC
//
//  Created by Yago Souza Ramos on 4/13/25.
//

import UIKit
import SpriteKit
import SwiftUI
class GameViewController: UIViewController {
    
    var spriteKitView = SKView()
    let scene = GameScene()
    let backgroundView = UIHostingController(rootView: BackgroundGame())
    
    var changeDirectionBTN: UIButton! = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .gray
        return btn
    }()
    
    var changePlanetButton: UIButton! = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .gray
        return btn
    }()
    
    @objc func changeDirection(_ sender: UIButton) {
//        scene.changeDirection(planet: scene.planets[scene.currentPlanetIndex])
        scene.planetControllers[scene.currentPlanetIndex].reverseRotation()
    }
    
    @objc func changePlanet(_ sender: UIButton) {
        scene.planetControllers[scene.currentPlanetIndex].jump()
        scene.changePlanet()
        changePlanetButton.setTitle("\(scene.currentPlanetIndex)", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.addSubview(changeDirectionBTN)
        view.addSubview(changePlanetButton)
        
#if DEBUG
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = true
        spriteKitView.showsNodeCount = true
#endif
        
        changeDirectionBTN.addTarget(self, action: #selector(changeDirection), for: .touchUpInside)
        changeDirectionBTN.layer.zPosition = 10
        NSLayoutConstraint.activate([
            changeDirectionBTN.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            changeDirectionBTN.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            changeDirectionBTN.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            changeDirectionBTN.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        ])
        
        changePlanetButton.addTarget(self, action: #selector(changePlanet), for: .touchUpInside)
        changePlanetButton.layer.zPosition = 10
        NSLayoutConstraint.activate([
            changePlanetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            changePlanetButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            changePlanetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            changePlanetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
        ])
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
