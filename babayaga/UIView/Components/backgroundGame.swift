//
//  background.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/05/25.
//

import SwiftUI

struct BackgroundGame: View {
    var body: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .brightness(-0.1)
            
            Image("moon")
                .padding(.bottom, 700)
                .padding(.leading, 250)
                .brightness(0.2)
            Group {
                Image("arvores")
                    .resizable()
                
                Image("bigarvore")
                    .resizable()
                
                Image("bigarvore2")
                    .scaledToFill()
                    .padding(.top, 346)
                    .padding(.leading, 200)
            }.opacity(0.45)
            
            Image("shinyEye")
                .padding(.bottom, 350)
                .padding(.trailing, 105)
                .brightness(0.6)
            
            Image("shinyEye")
                .padding(.bottom, 450)
                .padding(.trailing, 150)
                .brightness(0.6)

            Image("eyefundo")
                .padding(.top, 10)
                .padding(.leading, 300)
            
            Image("eyefundo")
                .padding(.bottom, 700)
                .padding(.trailing, 270)
            
            Image("vector")
                .resizable()
            
            Image("textura")
                .resizable()
        }
        
    }
}

#Preview {
    BackgroundGame()
}
