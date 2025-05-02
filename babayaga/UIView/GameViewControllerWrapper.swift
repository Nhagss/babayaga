//
//  GameViewControllerWrapper.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 30/04/25.
//

import SwiftUI
import SpriteKit

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        return GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Você pode atualizar o controller aqui se precisar
    }
}

enum Views: Hashable {
    case GameScene
}

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

