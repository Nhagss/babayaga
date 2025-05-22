//
//  PlayItButton.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 20/05/25.
//

import SwiftUI

struct PlayItButton: View {
    var body: some View {
        ZStack {
            Image("backgroundpause")
                .resizable()
                .frame(width: 267, height: 60)
            HStack(spacing: 40){
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                Text("Jogar")
                    .font(.custom("GermaniaOne-Regular", size: 37))
                    .foregroundStyle(Color.white)
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    
            }
        }
    }
}

#Preview {
    PlayItButton()
}
