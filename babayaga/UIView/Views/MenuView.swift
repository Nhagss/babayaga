//
//  MenuView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 08/05/25.
//

import SwiftUI
import Foundation

struct MenuView: View {
    @EnvironmentObject var router: Router
    var onClose: (() -> Void)? = nil
    
    let menubuttons: [MenuButton] = [
        MenuButton(label: "Reiniciar fase", icon: "revolving", destination: .GameViewController),
        MenuButton(label: "Voltar ao Menu", icon: "home", destination: .InitialScreen),
        MenuButton(label: "Retornar ao jogo", icon: nil, destination: .GameViewController),
    ]
        
    var body: some View {
            ZStack {
                BackgroundGame()
                    .blur(radius: 5)
                Image("menu_background")
                    .padding(.bottom, 20)
                
                VStack(spacing: 35) {
                    ForEach(menubuttons) { button in
                        Button(action: {
                            router.path.append(button.destination)
                            
                        }) {
                            HStack {
                                if let icon = button.icon, !icon.isEmpty {
                                    Image(icon)
                                }
                                Text(button.label)
                                    .font(.custom("Quicksand-Medium", size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }/*.environmentObject(router)*/
            
            }
    }

#Preview {
    MenuView()
}
