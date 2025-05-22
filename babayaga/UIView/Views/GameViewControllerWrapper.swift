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
    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Atualizações do controller, se necessário
    }
}


