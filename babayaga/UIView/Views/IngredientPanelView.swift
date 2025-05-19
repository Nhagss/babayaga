//
//  IngredientPanelView.swift
//  babayaga
//
//  Created by honorio on 13/05/25.
//

import SwiftUI
import SpriteKit

struct IngredientPanelView: View {
    
    @ObservedObject var gameSceneManager: GameSceneManager
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(gameSceneManager.ingredients, id: \.id) { ingredient in
                HStack(spacing: 2) {
                    // Substitua por seu asset .goldCoin1 ou use SF Symbols para teste
                    Image("ingredient\(ingredient.id)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("x\(ingredient.remaining)")
                        .font(.custom("GermaniaOne-Regular", size: 23))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(Color.black)
                .overlay(
                    Capsule()
                        .stroke(Color.white, lineWidth: 2)
                )
        )
    }
}
