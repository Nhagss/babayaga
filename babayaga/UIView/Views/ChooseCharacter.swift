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
            
            Text("\(getCharacterName())")
                .font(.custom("GermaniaOne-Regular", size: 60))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 600)
            
            Image("pedestal")
                .resizable()
                .frame(width: 147, height: 57)
                .padding(.top, 210)
            
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
                                            PlayerSpriteView(skin: skin)
                                                .frame(width: 500, height: 500)
                                                .id(index)
                                    }
                                }
                                .padding(.horizontal, 60)
                            }
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
            }
            
            
            
            Button {
                let selected = CharacterSkin.allCases[currentIndex]
                UserDefaults.standard.set(selected.rawValue, forKey: "selectedSkin")
                InitialScreen.startGame()
            } label: {
                PlayItButton()
                    .padding(.top, 400)
            }
        }
    }
    func getCharacterName() -> String {
        switch currentIndex {
        case 0:
            return "Morgana"
        case 1:
            return "Rasputin"
        default:
            return "Don't have a name yet"
        }
    }
}

#Preview {
    ChooseCharacter()
}
