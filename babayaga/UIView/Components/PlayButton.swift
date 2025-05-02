//
//  PlayButton.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/05/25.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        ZStack{
            
            Image("play")
            
            Image("eye.play")
                .padding(.leading, -10)
        }
    }
}

#Preview {
    PlayButton()
}
