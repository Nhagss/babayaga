//
//  MenuView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 08/05/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Image("menu_background")
            
            VStack(spacing: 40) {
                HStack {
                    Image("revolving")
                    Text("Reiniciar fase")
                        .font(.custom("Quicksand-Medium", size: 27))
                        .foregroundStyle(.white)
                    
                }
                HStack {
                    Image("home")
                    Text("Voltar ao Menu")
                        .font(.custom("Quicksand-Medium", size: 27))
                        .foregroundStyle(.white)
                    
                }
                
                Text("Retornar ao jogo")
                    .font(.custom("Quicksand-Medium", size: 27))
                    .foregroundStyle(.white)
                
            }
            .padding(.top)
        }
    }
}

#Preview {
    MenuView()
}
