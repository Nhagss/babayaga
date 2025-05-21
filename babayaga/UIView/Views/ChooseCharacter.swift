//
//  ChooseCharacter.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 19/05/25.
//
import SwiftUI

struct ChooseCharacter: View {
    @ObservedObject var router: Router = Router.shared
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
                .blur(radius: 3)
            
            VStack {
                ScrollViewReader { proxy in
                    HStack {
                        Button(action: {
                            if currentIndex > 0 { currentIndex -= 1 }
                        }) {
                            Image("Back")
                        }
                        .padding(.leading, 22)
                        
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 40) {
                                    ForEach(Array(CharacterSkin.allCases.enumerated()), id: \.offset) { index, skin in
                                        VStack(spacing: 0) {
                                            Image(skin.rawValue)
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
                                .frame(width: 147, height: 57)
                        }
                        
                        Button(action: {
                            if currentIndex < CharacterSkin.allCases.count - 1 { currentIndex += 1 }
                        }) {
                            Image("Next")
                        }
                        .padding(.trailing, 22)
                    }
                    
                    .onAppear {
                        DispatchQueue.main.async {
                            proxy.scrollTo(currentIndex, anchor: .center)
                        }
                    }
                    
                    .onChange(of: currentIndex) { newIndex in
                        withAnimation {
                            proxy.scrollTo(newIndex, anchor: .center)
                        }
                    }
                    
                }
                
                Button(action: {
                    let selected = CharacterSkin.allCases[currentIndex]
                    UserDefaults.standard.set(selected.rawValue, forKey: "selectedSkin")
                    InitialScreen.startGame()
                }) {
                    PlayItButton()
                }
            }
        }
    }
}

#Preview {
    ChooseCharacter()
}
