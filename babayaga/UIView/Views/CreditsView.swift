//
//  CreditsView.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//

import SwiftUI

struct Developer: Identifiable {
    var id: UUID
    var name: String
    var image: String
    var linkedin: String
}

struct CreditsView: View {
    let developers = [
        Developer(id: UUID(), name: "Daniel Oppelt", image: "IconDO", linkedin: "https://www.linkedin.com/in/daniel-oppelt-13995b208/"),
        Developer(id: UUID(), name: "Honório Filho", image: "IconHF", linkedin: "https://www.linkedin.com/in/honoriofilho/"),
        Developer(id: UUID(), name: "João Roberto", image: "IconJR", linkedin: "https://www.linkedin.com/in/joão-roberto-72a05b217/"),
        Developer(id: UUID(), name: "Melissa Guedes", image: "IconMG", linkedin: "https://www.linkedin.com/in/melissafreireguedes/"),
        Developer(id: UUID(), name: "Yago Ramos", image: "IconYR", linkedin: "https://www.linkedin.com/in/yago-souza-ramos-621670211/")
    ]
    
    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ForEach(developers) { developer in
                    Button(action: {
                        if let url = URL(string: developer.linkedin) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        DeveloperCell(name: developer.name, imageName: developer.image)
                            .padding(.bottom, 10)
                    }
                }
                NavigationLink(destination: SoundsCredits()) {
                    Text("credits_soundtrack")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .underline(true , color: .white)
                        .bold()
                }
            }
            .padding()
        }
    }
}

#Preview {
    CreditsView()
}

