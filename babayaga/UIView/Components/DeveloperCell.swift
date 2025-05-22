//
//  DeveloperCell.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//

import SwiftUI

struct DeveloperCell: View {
    let name: String
    let imageName: String

    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .fill(Color.black)
            .frame(width: 332, height: 95)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.white, lineWidth: 2)
            )
            .overlay(
                HStack(spacing: 16) {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))

                    Text(name)
                        .font(.custom("GermaniaOne-Regular", size: 24))
                        .foregroundStyle(.white)

                    Spacer()
                }
                .padding(.horizontal)
            )
    }
}

#Preview {
    DeveloperCell(name: "Melissa Guedes", imageName: "joao")
}
