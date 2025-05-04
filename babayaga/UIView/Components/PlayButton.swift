//
//  PlayButton.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/05/25.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        VStack {
            ZStack {
                
                Image("play")
                
                Image("eye.play")
                    .padding(.trailing, 10)
                
            }
            Text("Jogar")
                .font(.custom("Quicksand-Regular", size: 27))
                .foregroundStyle(.white)
            
        }
    }
}

#Preview {
    PlayButton()
}
