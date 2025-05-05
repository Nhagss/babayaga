//
//  InitialScreen.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/04/25.
//

import SwiftUI
import SpriteKit

struct InitialScreen: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack (path: $router.path) {
            
            ZStack {
                
                Background()
                
                Image("moon")
                    .padding(.bottom, 600)
                    .padding(.leading, 250)
                
                Text("Baba")
                    .font(.custom("GermaniaOne-Regular", size: 106))
                    .padding(.bottom, 400)
                    .padding(.trailing, 70)
                    .foregroundStyle(.white)
                
                Text("Yaga")
                    .font(.custom("GermaniaOne-Regular", size: 106))
                    .padding(.bottom, 220)
                    .padding(.leading, 30)
                    .foregroundStyle(.white)
                
                Button(action: {
                    router.goToGameScene()
                }) {
                    VStack {
                        ZStack {
                            
                            Image("play")
                            
                            Image("eye.play")
                                .padding(.trailing, 10)
                            
                        }
                        Text("Jogar")
                            .font(.custom("Quicksand-Regular", size: 27))
                            .foregroundStyle(.white)
                        
                    }
                    .padding(.top, 150)
                    
                    .navigationDestination(for: Views.self) { view in
                        switch view {
                        case .GameViewController:
                            GameViewControllerWrapper()
                        }
                    }
                    
                }
            }
            .ignoresSafeArea()
            .environmentObject(router)
            
        }
    }
}

#Preview {
    InitialScreen()
}
