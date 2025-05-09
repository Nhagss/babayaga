//
//  MenuView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 08/05/25.
//

import SwiftUI

struct MenuView: View {
    let labels = ["Reiniciar fase", "Voltar ao Menu", "Retornar ao jogo"]
    let icons = ["revolving", "home", ""]
    let View : [AnyView] = []

    var body: some View {
        ZStack {
            Image("menu_background")

            VStack(spacing: 40) {
                ForEach(0..<labels.count, id: \.self) { index in
                    HStack{
                        if !icons[index].isEmpty {
                            Image(icons[index])
                        }
                        Text(labels[index])
                            .font(.custom("Quicksand-Medium", size: 24))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    MenuView()
}
