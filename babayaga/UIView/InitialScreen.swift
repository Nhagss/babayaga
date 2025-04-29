//
//  InitialScreen.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/04/25.
//

import SwiftUI
import SpriteKit

struct GameSceneView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct InitialScreen: View {
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink(destination: GameSceneView()) {
                        ZStack {
                            Circle()
                                .frame(width: 80)
                            Image(systemName: "window.ceiling.closed")
                                .foregroundStyle(.white)
                        }
                            
                    }
                NavigationLink(destination: GameSceneView()) {
                    ZStack {
                        Circle()
                            .frame(width: 100)
                        Image(systemName: "play.fill")
                            .foregroundStyle(.white)
                    }
                    
                }
                NavigationLink(destination: GameSceneView()) {
                    ZStack {
                        Circle()
                            .frame(width: 80)
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                    }
                    
                }
                .navigationTitle("Main Menu")
            }
        }
    }
}

#Preview {
    InitialScreen()
}


#Preview {
    InitialScreen()
}
