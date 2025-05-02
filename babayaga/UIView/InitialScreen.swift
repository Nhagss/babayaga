//
//  InitialScreen.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/04/25.
//

import SwiftUI
import SpriteKit

import SwiftUI

struct InitialScreen: View {
    var body: some View {
        ZStack{
            
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
            
            PlayButton()
                .padding(.top, 150)
    
        }
        .ignoresSafeArea()
            
        }
}

#Preview {
    InitialScreen()
}
