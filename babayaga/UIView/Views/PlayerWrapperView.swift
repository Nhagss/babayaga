//
//  PlayerWrapperView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/05/25.
//
import SpriteKit
import SwiftUI

struct PlayerSpriteView: UIViewRepresentable {
    let skin: CharacterSkin

    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.allowsTransparency = true
        skView.backgroundColor = .clear

        let scene = SKScene(size: CGSize(width: 250, height: 250))
        scene.backgroundColor = .clear
        scene.scaleMode = .aspectFit

        let player = PlayerView(skin: skin)
        player.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2 - 30)
        scene.addChild(player)

        skView.presentScene(scene)
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {}
}
