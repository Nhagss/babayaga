//
//  GameViewControllerWrapper.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 30/04/25.
//

import SwiftUI
import SpriteKit

// MARK: Usada para integrar um UIViewController do UIKit dentro de uma interface SwiftUI.
struct GameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewControllerBase {
        GameViewControllerBase()
    }

    func updateUIViewController(_ uiViewController: GameViewControllerBase, context: Context) {
        // Atualizações do controller, se necessário
    }
}

// MARK: define uma view SwiftUI que exibe uma cena SpriteKit
struct GameSceneView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .navigationBarHidden(true)
    }
}


