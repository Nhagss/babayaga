//
//  MenuView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 08/05/25.
//

import SwiftUI
import Foundation

struct MenuView: View {
    @ObservedObject var router: Router = Router.shared
    @Environment(\.dismiss) var dismiss
    
    var onTap: ((MenuButton) -> Void)?
    var onClose: (() -> Void)? = nil
    
    let menubuttons: [MenuButton] = [
        MenuButton(label: NSLocalizedString("menu_reset", comment: ""), icon: "revolving", destination: .RestartGame),
        MenuButton(label: NSLocalizedString("menu_back", comment: ""), icon: "home", destination: .InitialScreen),
        MenuButton(label: NSLocalizedString("menu_resume", comment: ""), icon: nil, destination: .GameViewController),
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
                        dismiss()
                        self.onTap?(button)
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
        }
    }
}

#Preview {
    MenuView()
}
