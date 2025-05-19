//
//  ChooseCharacter.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 19/05/25.
//

import SwiftUI

struct ChooseCharacter: View {
    @State private var currentIndex = 0
    let characters = ["morgana", "oppelt"]

    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
                .blur(radius: 3)

            ScrollViewReader { proxy in
                HStack {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        Image("Back")
                    }
                    .padding(.leading, 22)
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 40) {
                                ForEach(Array(characters.enumerated()), id: \.offset) { index, name in
                                    VStack(spacing: 0) {
                                        Image(name)
                                            .resizable()
                                            .frame(width: 250, height: 250)
                                            .id(index)
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal, 60)
                        }
                        Image("pedestal")
                            .resizable()
                            .frame(width: 250, height: 50)
                            .offset(y: -20)
                    }

                    Button(action: {
                        if currentIndex < characters.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        Image("Next")
                    }
                    .padding(.trailing, 22)
                }
                .onChange(of: currentIndex) { newIndex in
                    withAnimation {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
        }
    }
}


#Preview {
    ChooseCharacter()
}
