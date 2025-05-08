//
//  GameControlsView.swift
//  babayaga
//
//  Created by honorio on 08/05/25.
//

import SwiftUI

struct GameControlsView: View {
    var onChangeDirection: () -> Void
    var onChangePlanet: () -> Void
    
    var body: some View {
        ZStack {
            Color.clear // Para garantir transparência
            HStack(spacing: 40) { // Aumentando o espaçamento
                ButtonComponent(image: .portalButton, action: onChangePlanet)
                ButtonComponent(image: .reverseButton, action: onChangeDirection)
            }
            .padding(.horizontal, 40) // Afastando das bordas
            .padding(.bottom, 50) // Ajustando a altura
        }
        .frame(maxWidth: .infinity)
    }
}
