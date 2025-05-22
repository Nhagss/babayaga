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
            Color.clear
            HStack(spacing: 40) {
                ButtonComponent(imageName: "portal_button", action: onChangePlanet)
                ButtonComponent(imageName: "reverse_button", action: onChangeDirection)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    GameControlsView(onChangeDirection: {}, onChangePlanet: {})
}
